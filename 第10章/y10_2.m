%模糊逼近
clc % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口

T=0.1; %步长
x1=-1:T:1; % 模糊集变化范围
x2=-1:T:1; % 模糊集变化范围

L=2; % 模糊集变化范围长度
h=0.2; % 逼近精度
N=L/h+1; %模糊集的个数

for i=1:1:N     %N MF
  for j=1:1:N
    e1(i)=-1+L/(N-1)*(i-1);% 模糊集的边界值
    e2(j)=-1+L/(N-1)*(j-1);% 模糊集的边界值
	gx(i,j)=0.52+0.1*e1(i)^3+0.28*e2(j)^3-0.06*e1(i)*e2(j); % 逼近函数
	end
end

df=zeros(L/T+1,L/T+1); %初始值
cf=zeros(L/T+1,L/T+1); %初始值

for m=1:1:N                       %u1 change from 1 to N
   % 隶属度函数
   if m==1
		u1=trimf(x1,[-1,-1,-1+L/(N-1)]);   %First u1
   elseif m==N
		u1=trimf(x1,[1-L/(N-1),1,1]);      %Last u1
   else
        u1=trimf(x1,[e1(m-1),e1(m),e1(m+1)]); 
   end
    figure(1);
    hold on;
    plot(x1,u1,'r','LineWidth',2);
    grid on %网格化
    xlabel('x1');ylabel('隶属函数模糊集');
    title('x1的隶属函数模糊集')

    for n=1:1:N                              %u2 change from 1 to N
        if n==1
            u2=trimf(x2,[-1,-1,-1+L/(N-1)]);   %First u2  
        elseif n==N
            u2=trimf(x2,[1-L/(N-1),1,1]);      %Last u2
        else 
            u2=trimf(x2,[e2(n-1),e2(n),e2(n+1)]);
        end
        figure(2);
        hold on;
        plot(x2,u2,'r','LineWidth',2);
        grid on
        xlabel('x2');ylabel('隶属函数模糊集');
        title('x2的隶属函数模糊集')

        for i=1:1:L/T+1
            for j=1:1:L/T+1
                d=df(i,j)+u1(i)*u2(j);
                df(i,j)=d;
                c=cf(i,j)+gx(m,n)*u1(i)*u2(j);
                cf(i,j)=c; 
            end
        end
    end
end

%%%%%%%%%%%
for i=1:1:L/T+1
    for j=1:1:L/T+1
        f(i,j)=cf(i,j)/df(i,j);% 模糊系统
        y(i,j)=0.52+0.1*x1(i)^3+0.28*x2(j)^3-0.06*x1(i)*x2(j);
    end
end
figure(3);
subplot(211);
surf(x1,x2,f);
grid on
box on
title('模糊系统f(x)');

subplot(212);
surf(x1,x2,y);
grid on
box on
title('逼近函数g(x)');

figure(4);
surf(x1,x2,f-y);
title('逼近误差');