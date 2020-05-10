%模糊逼近
clc % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口

L1=-3;L2=3; % U范围
L=L2-L1; % 模糊集变化范围长度

h=0.2;  % 逼近精度
N=L/h+1; %模糊集的个数
T=0.01; %步长

x=L1:T:L2; % 模糊集变化范围
for i=1:N
    e(i)=L1+L/(N-1)*(i-1); % 模糊集的边界值
end

c=0;d=0; %初始值
for j=1:N
   % 隶属度函数
   if j==1
		u=trimf(x,[e(1),e(1),e(2)]);    %The first MF
   elseif j==N
		u=trimf(x,[e(N-1),e(N),e(N)]);  %The last MF
   else
	    u=trimf(x,[e(j-1),e(j),e(j+1)]); 
   end
   hold on;
   plot(x,u,'r','LineWidth',2);
   c=c+sin(e(j))*u;  % 分子
   d=d+u;   % 分母
end
xlabel('x');ylabel('隶属函数模糊集');

for k=1:L/T+1
    f(k)=c(k)/d(k); % 模糊系统
end
    
y=sin(x);
figure(2);
plot(x,f,'r',x,y,'k');
xlabel('x');ylabel('模糊逼近');
grid on%网格化
title('模糊逼近')

figure(3);
plot(x,f-y,'k','LineWidth',2); 
grid on%网格化
xlabel('x');ylabel('模糊逼近误差');
title('模糊逼近误差')
