from graphviz import Digraph

def create_state_diagram():
    # 创建有向图
    dot = Digraph(comment='SD Buffer Descriptor State Machine')
    dot.attr(rankdir='LR')
    
    # 设置节点样式
    dot.attr('node', shape='circle')
    
    # 添加状态节点
    dot.node('IDLE', 'IDLE')
    dot.node('WRITE', 'WRITE')
    dot.node('READ', 'READ')
    
    # 添加转换边
    dot.edge('IDLE', 'WRITE', 'we_m & free_bd > 0')
    dot.edge('WRITE', 'IDLE', 'write complete')
    dot.edge('IDLE', 'READ', 're_s')
    dot.edge('READ', 'IDLE', 'read complete')
    
    
    # 保存图
    dot.render('bd-state-transition', format='png', cleanup=True)

if __name__ == '__main__':
    create_state_diagram()