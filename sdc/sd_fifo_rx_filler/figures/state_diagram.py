from graphviz import Digraph

def create_state_diagram():
    # 创建有向图
    dot = Digraph(comment='SD FIFO RX Filler State Diagram')
    dot.attr(rankdir='LR')
    
    # 设置节点样式
    dot.attr('node', shape='circle')
    
    # 添加状态节点
    dot.node('IDLE', 'IDLE')
    dot.node('READ', 'READ')
    dot.node('WRITE', 'WRITE')
    
    # 添加转换边
    # IDLE -> READ
    dot.edge('IDLE', 'READ', 'en & !empty & wb_free\n(rd=1)')
    
    # READ -> WRITE
    dot.edge('READ', 'WRITE', 'rd & wb_we_o & wb_cyc_o & wb_stb_o\n(m_wb_dat_o=dat_o)')
    
    # WRITE -> IDLE
    dot.edge('WRITE', 'IDLE', 'm_wb_ack_i & !wb_free\n(offset += MEM_OFFSET)')
    
    # 返回IDLE的条件
    dot.edge('READ', 'IDLE', '!en\n(reset_rx_fifo=1)')
    dot.edge('WRITE', 'IDLE', '!en\n(reset_rx_fifo=1)')
    
    # 自循环条件
    dot.edge('IDLE', 'IDLE', 'en=0 or empty or\n!wb_free')
    
    # 保存图
    dot.render('rx-filler-state', format='jpg', cleanup=True)

if __name__ == '__main__':
    create_state_diagram()