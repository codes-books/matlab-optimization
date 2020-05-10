%综合输出曲线
clc % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口

ts=0.001;
sys=tf([1.6],[1 1.5 1.6],'inputdelay',0.1);
dsys=c2d(sys,ts,'z');
[num,den]=tfdata(dsys,'v');
u_1=0.0;u_2=0.0;
y_1=0.0;y_2=0.0;
x=[0,0,0]';
error_1=0;
% SOA
for k=1:1:10000
    time(k)=k*ts;
    kp=3.03;
    ki=3.21;
    kd=1.80;
    rin(k)=1;
    u(k)=kp*x(1)+kd*x(2)+ki*x(3);
    yout1(k)=-den(2)*y_1-den(3)*y_2+num(2)*u_1+num(3)*u_2;
    error1(k)=rin(k)-yout1(k);
    %return of parameters
    u_2=u_1;u_1=u(k);
    y_2=y_1;y_1=yout1(k);
    x(1)=error1(k);           % Calculating  P
    x(2)=(error1(k)-error_1)/ts;   %          D
    x(3)=x(3)+error1(k)*ts;       %           I
    error_1=error1(k);
end

u_1=0.0;u_2=0.0;
y_1=0.0;y_2=0.0;
x=[0,0,0]';
error_1=0;
% PSO
for k=1:1:10000
    time(k)=k*ts;
    kp=3.18;
    ki=3.4;
    kd=1.61;
    rin(k)=1;
    u(k)=kp*x(1)+kd*x(2)+ki*x(3);
    yout2(k)=-den(2)*y_1-den(3)*y_2+num(2)*u_1+num(3)*u_2;
    error2(k)=rin(k)-yout2(k);
    %return of parameters
    u_2=u_1;u_1=u(k);
    y_2=y_1;y_1=yout2(k);
    x(1)=error2(k);           % Calculating  P
    x(2)=(error2(k)-error_1)/ts;   %          D
    x(3)=x(3)+error2(k)*ts;       %           I
    error_1=error2(k);
    
end

u_1=0.0;u_2=0.0;
y_1=0.0;y_2=0.0;
x=[0,0,0]';
error_1=0;
% GA
 for k=1:1:10000
    time(k)=k*ts;
    kp=4.30;
    ki=3.72;
    kd=1.04;
   rin(k)=1;
    u(k)=kp*x(1)+kd*x(2)+ki*x(3);
    yout3(k)=-den(2)*y_1-den(3)*y_2+num(2)*u_1+num(3)*u_2;
    error3(k)=rin(k)-yout3(k);
    %return of parameters
    u_2=u_1;u_1=u(k);
    y_2=y_1;y_1=yout3(k);
    x(1)=error3(k);           % Calculating  P
    x(2)=(error3(k)-error_1)/ts;   %          D
    x(3)=x(3)+error3(k)*ts;       %           I
    error_1=error3(k);
    
 end
 
figure(1)
plot(time,rin,'LineWidth',3)
hold on
plot(time,yout1,'r-','LineWidth',3)
plot(time,yout2,'g--','LineWidth',3)
plot(time,yout3,'k.--','LineWidth',3)
xlabel('time(s)'),ylabel('rin,yout');
legend('rin','SOA','PSO','GA',1)
grid on
title('阶跃响应输出曲线综合比较曲线')
hold off 

figure(2)
plot(time,error1,'r','LineWidth',3)
hold on
plot(time,error2,'g--','LineWidth',3)
plot(time,error3,'k.--','LineWidth',3)
xlabel('time(s)'),ylabel('rin,error');
legend('SOA','PSO','GA',2)
grid on
title('阶跃响应输出曲线误差综合比较') 
hold off
