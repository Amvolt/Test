/*50MHz周期20ns*/

module Receiver(SerialIn, Clock, Reset, UpdatePulse, ReceivedData);
input Clock;//时钟
input Reset;//复位线,高电平有效
input SerialIn;//输入串口数据
output UpdatePulse;//数据更新提示脉冲
reg [7:0] ReceivedData = 8'b00000000;//当前存储的值，初始化

/*------------------------------------------------计数进程----------------------------*/
reg CountState = 1'b0;//计数进程触发
reg[13] DelayCount = 1'b0;//延迟计数
reg[4] BitCount = 1'b0;//接收位数计数
always @(Clock, posedge Reset)//计数进程
begin
	if(Reset or !CountState)//如果复位或者空闲状态，就清零寄存器
		begin
			DelayCount <= 0;
			BitCount <= 0;
			CountFlag <= 0;
		end
	else
		begin
			if(DelayCount != 13'b1001110100011)//(5027)如果未计满5028（1个串口位周期）
				begin
					DelayCount <= DelayCount+1;//延迟计数＋1
				end
			else				
				begin			
					DelayCount <= 0;
					if(BitCount != 4'b1001)//(9)如果未计满9
						begin
							BitCount <= BitCount+1;//位计数＋1（结束1位）
						end
					else
						begin
							BitCount <= 0;//复位
							CountFlag <= 0;//一次接收计数周期停止
						end
				end
		end
end

/*------------------------------------------------数据接收进程------------------------*/
reg ReceiveState = 1'b0;//数据接收状态，0为空闲，1为忙碌（默认为忙碌）//隐式initial
always @(Clock, posedge Reset)//计数进程
begin
	if(Reset)//如果复位或者空闲状态，就清零寄存器
		begin
			
		end
end 

--------------------------------------