%x1(ʱ��),y1��y2��y3��y4��y5��y6��������ʳƷ����ۣ�����Matlab�е�workplace�����룻
%�����ѷ����ʳƷ�ļ۸�--ʱ������
clc,clear,close all
load('x.mat')
load('y1.mat')
%�߲���ʳƷ��������ͼ
for i=1:38
   for j=1:15
      z444 (i,j)=z44(i,j)/z4(i,j);
   end
end
for i=1:15
   subplot(4,4,i);
   plot(x1,z444(:,i) ,x2,0.03*ones(1,39),'r--',x2,-0.03*ones(1,39),'r--',x2,0.05*ones(1,39) ,'r--',x2,-0.05*ones(1,39) ,'r--');hold on
end
