%×ÛºÏÊä³öÇúÏß
clear all;
close all;
ts=0.001;
sys=tf([1.05],[6.8e-6 2.47e-3 0.7925]);
dsys=c2d(sys,ts,'z');
[num,den]=tfdata(dsys,'v');
u_1=0.0;u_2=0.0;
y_1=0.0;y_2=0.0;
x=[0,0,0]';
error_1=0;
for k=1:1:100
    time(k)=k*ts;
    kp=0.0409;
    ki=64.3062;
    kd=0;
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
for k=1:1:100
    time(k)=k*ts;
    kp=0.1094;
    ki=67.6368;
    kd=0;
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
 for k=1:1:100
    time(k)=k*ts;
     kp=0.2695;
    ki=63.2737;
    kd=0;
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
 plot(time,rin,'LineWidth',2)
 hold on
 plot(time,yout1,'r*','LineWidth',2)
 plot(time,yout2,'g--','LineWidth',2)
 plot(time,yout3,'k','LineWidth',2)
 xlabel('time(s)'),ylabel('rin,yout');
 legend('rin','SOA','PSO','GA',1)
 grid on
 hold off
 
 figure(2)
 plot(time,error1,'r*','LineWidth',2)
 hold on
 plot(time,error2,'g--','LineWidth',2)
 plot(time,error3,'k','LineWidth',2)
 xlabel('time(s)'),ylabel('rin,error');
 grid on
 legend('SOA','PSO','GA',2)
  hold off