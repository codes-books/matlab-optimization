%ģ���ƽ�
clc % ����
clear all; % ɾ��workplace����
close all; % �ص���ʾͼ�δ���

L1=-3;L2=3; % U��Χ
L=L2-L1; % ģ�����仯��Χ����

h=0.2;  % �ƽ�����
N=L/h+1; %ģ�����ĸ���
T=0.01; %����

x=L1:T:L2; % ģ�����仯��Χ
for i=1:N
    e(i)=L1+L/(N-1)*(i-1); % ģ�����ı߽�ֵ
end

c=0;d=0; %��ʼֵ
for j=1:N
   % �����Ⱥ���
   if j==1
		u=trimf(x,[e(1),e(1),e(2)]);    %The first MF
   elseif j==N
		u=trimf(x,[e(N-1),e(N),e(N)]);  %The last MF
   else
	    u=trimf(x,[e(j-1),e(j),e(j+1)]); 
   end
   hold on;
   plot(x,u,'r','LineWidth',2);
   c=c+sin(e(j))*u;  % ����
   d=d+u;   % ��ĸ
end
xlabel('x');ylabel('��������ģ����');

for k=1:L/T+1
    f(k)=c(k)/d(k); % ģ��ϵͳ
end
    
y=sin(x);
figure(2);
plot(x,f,'r',x,y,'k');
xlabel('x');ylabel('ģ���ƽ�');
grid on%����
title('ģ���ƽ�')

figure(3);
plot(x,f-y,'k','LineWidth',2); 
grid on%����
xlabel('x');ylabel('ģ���ƽ����');
title('ģ���ƽ����')
