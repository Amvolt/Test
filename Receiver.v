/*50MHz����20ns*/

module Receiver(SerialIn, Clock, Reset, UpdatePulse, ReceivedData);
input Clock;//ʱ��
input Reset;//��λ��,�ߵ�ƽ��Ч
input SerialIn;//���봮������
output UpdatePulse;//���ݸ�����ʾ����
reg [7:0] ReceivedData = 8'b00000000;//��ǰ�洢��ֵ����ʼ��

/*------------------------------------------------��������----------------------------*/
reg CountState = 1'b0;//�������̴���
reg[13] DelayCount = 1'b0;//�ӳټ���
reg[4] BitCount = 1'b0;//����λ������
always @(Clock, posedge Reset)//��������
begin
	if(Reset or !CountState)//�����λ���߿���״̬��������Ĵ���
		begin
			DelayCount <= 0;
			BitCount <= 0;
			CountFlag <= 0;
		end
	else
		begin
			if(DelayCount != 13'b1001110100011)//(5027)���δ����5028��1������λ���ڣ�
				begin
					DelayCount <= DelayCount+1;//�ӳټ�����1
				end
			else				
				begin			
					DelayCount <= 0;
					if(BitCount != 4'b1001)//(9)���δ����9
						begin
							BitCount <= BitCount+1;//λ������1������1λ��
						end
					else
						begin
							BitCount <= 0;//��λ
							CountFlag <= 0;//һ�ν��ռ�������ֹͣ
						end
				end
		end
end

/*------------------------------------------------���ݽ��ս���------------------------*/
reg ReceiveState = 1'b0;//���ݽ���״̬��0Ϊ���У�1Ϊæµ��Ĭ��Ϊæµ��//��ʽinitial
always @(Clock, posedge Reset)//��������
begin
	if(Reset)//�����λ���߿���״̬��������Ĵ���
		begin
			
		end
end 

--------------------------------------