FROM node:20-slim

# 安装构建与运行工具（含 g++）；通过源码构建固定版本 Verilator
ARG VERILATOR_VERSION=5.030
ARG VERILATOR_MAKE_JOBS=1
RUN apt-get update && apt-get install -y \
    autoconf \
    bison \
    help2man \
    build-essential \
    ca-certificates \
    flex \
    m4 \
    perl \
    git \
    gosu \
    iptables \
    libfl-dev \
    make \
    pkg-config \
    python3 \
    python3-joblib \
    python3-numpy \
    sudo \
    wget \
    yosys && \
    rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    wget -q "https://github.com/verilator/verilator/archive/refs/tags/v${VERILATOR_VERSION}.tar.gz" -O /tmp/verilator.tar.gz && \
    mkdir -p /tmp/verilator && \
    tar -xzf /tmp/verilator.tar.gz -C /tmp/verilator --strip-components=1 && \
    cd /tmp/verilator && \
    if [ ! -f configure ]; then \
        autoconf; \
    fi; \
    chmod +x configure; \
    ./configure --prefix=/usr/local; \
    make -j ${VERILATOR_MAKE_JOBS}; \
    make install; \
    rm -rf /tmp/verilator /tmp/verilator.tar.gz

# 创建非 root 用户并设置密码
RUN useradd -m -s /bin/bash -u 1001 claudeuser && \
    echo 'claudeuser:claude123' | chpasswd && \
    usermod -aG sudo claudeuser && \
    echo 'claudeuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# 禁止运行时检查更新
ENV CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
ENV CLAUDE_CODE_NO_AUTO_UPDATE=1
ENV CLAUDE_CODE_UPDATE_CHECK_INTERVAL=0

WORKDIR /workspace
RUN chown -R claudeuser:claudeuser /workspace

# 复制 entrypoint 脚本
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
RUN apt-get remove -y wget && apt-get autoremove -y
CMD ["bash"]
