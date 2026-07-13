#!/bin/bash
set -e

mkdir -p /tmp/bin
[ -L /tmp/bin/claude ] || ln -s /usr/local/lib/node_modules/@anthropic-ai/claude-code/cli.js /tmp/bin/claude
[ -L /tmp/bin/claude-trace ] || ln -s /usr/local/lib/node_modules/@mariozechner/claude-trace/dist/cli.js /tmp/bin/claude-trace

if [ "${NETWORK_ALLOWLIST:-0}" = "1" ]; then
    if command -v iptables >/dev/null 2>&1; then
        ALLOWED_HOST="${NETWORK_ALLOWED_HOST:-}"
        ALLOWED_IPS="${NETWORK_ALLOWED_IPS:-}"
        DNS_SERVERS=""

        if [ -f /etc/resolv.conf ]; then
            DNS_SERVERS="$(awk '/^nameserver[[:space:]]+/ {print $2}' /etc/resolv.conf | tr '\n' ' ')"
        fi
        if [ -z "$DNS_SERVERS" ]; then
            DNS_SERVERS="127.0.0.11"
        fi

        if [ -z "$ALLOWED_IPS" ] && [ -n "$ALLOWED_HOST" ] && command -v getent >/dev/null 2>&1; then
            ALLOWED_IPS="$(getent ahosts "$ALLOWED_HOST" 2>/dev/null | awk 'NF {print $1}' | sort -u)"
        fi

        if [ -z "$ALLOWED_IPS" ]; then
            echo "[error] no allowed IP resolved for whitelist host '$ALLOWED_HOST', stop container"
            exit 1
        fi

        # 从 ANTHROPIC_BASE_URL 解析 API 端口（如 https://host:30443/... -> 30443），默认 443
        API_PORT="$(echo "${ANTHROPIC_BASE_URL:-}" | sed -E 's#^[a-zA-Z]+://[^/:]*:([0-9]+).*#\1#')"
        [ -z "$API_PORT" ] && API_PORT=443

        iptables -F OUTPUT
        iptables -P OUTPUT DROP
        iptables -A OUTPUT -o lo -j ACCEPT
        if iptables -m conntrack --help >/dev/null 2>&1; then
            iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
        else
            iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
        fi

        for ip in $ALLOWED_IPS; do
            iptables -A OUTPUT -d "$ip" -p tcp -m multiport --dports 80,443 -j ACCEPT
            # 单独放行 API 端口（可能是非标准端口如 30443）
            iptables -A OUTPUT -d "$ip" -p tcp --dport "$API_PORT" -j ACCEPT
            iptables -A OUTPUT -d "$ip" -p udp -m multiport --dports 53 -j ACCEPT
        done

        for dns in $DNS_SERVERS; do
            iptables -A OUTPUT -d "$dns" -p udp --dport 53 -j ACCEPT
            iptables -A OUTPUT -d "$dns" -p tcp --dport 53 -j ACCEPT
        done
    else
        echo "[warn] iptables not found, allowlist not enforced"
    fi
fi

export PATH="/tmp/bin:$PATH"

if [ "${RUN_AS_USER:-}" != "" ] && [ "$(id -u)" -eq 0 ]; then
    if command -v gosu >/dev/null 2>&1 && [ "${RUN_AS_USER}" != "root" ]; then
        # gosu 对数字 UID（不在 /etc/passwd）会把 HOME 重置成 /，
        # 导致 claude code 试图写 /.claude.json 失败、静默退出；
        # 用 env 显式重注入 HOME，绕过 gosu 的 passwd 查找
        exec gosu "$RUN_AS_USER" env "HOME=${HOME:-/tmp}" "$@"
    fi
fi

exec "$@"
