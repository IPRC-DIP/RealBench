from graphviz import Digraph

def create_state_diagram():
    dot = Digraph(comment='SD FIFO TX Filler State Diagram')
    dot.attr(rankdir='LR')
    
    # 设置节点样式
    dot.attr('node', shape='circle')
    
    # 添加状态节点
    dot.node('IDLE', 'IDLE')
    dot.node('REQUEST', 'REQUEST')
    dot.node('WRITE_FIFO', 'WRITE_FIFO')
    dot.node('DELAY', 'DELAY')
    
    # 添加主要转换边
    dot.edge('IDLE', 'REQUEST', 'en & !fe & ackd & !m_wb_ack_i')
    dot.edge('REQUEST', 'WRITE_FIFO', 'm_wb_ack_i')
    dot.edge('WRITE_FIFO', 'DELAY', '!m_wb_ack_i')
    dot.edge('DELAY', 'IDLE', 'delay | !en')
    
    # 返回IDLE
    dot.edge('REQUEST', 'IDLE', '!en')
    dot.edge('WRITE_FIFO', 'IDLE', '!en')
    
    # IDLE自循环
    dot.edge('IDLE', 'IDLE', '!en | fe | !ackd')
    
    # 保存图
    dot.render('tx-filler-state', format='jpg', cleanup=True)

if __name__ == '__main__':
    create_state_diagram()