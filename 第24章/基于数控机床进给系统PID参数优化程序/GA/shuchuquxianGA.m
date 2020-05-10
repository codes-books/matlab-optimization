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
    kp=0.2695;
    ki=63.2737;
    kd=0;
    rin(k)=1;
u(k)=kp*x(1)+kd*x(2)+ki*x(3);
if u(k)>=10
        u(k)=10;
end
if u(k)<=-10
   u(k)=-10;
end
yout(k)=-den(2)*y_1-den(3)*y_2+num(2)*u_1+num(3)*u_2;
error(k)=rin(k)-yout(k);
%return of parameters
u_2=u_1;u_1=u(k);
y_2=y_1;y_1=yout(k);
 x(1)=error(k);           % Calculating  P
 x(2)=(error(k)-error_1)/ts;   %          D
 x(3)=x(3)+error(k)*ts;       %           I
 error_1=error(k);
end
 %»æÍ¼
 figure(1)
 plot(time,rin,'b','LineWidth',3)
 hold on
 plot(time,yout,'r','LineWidth',3)
 xlabel('time(s)'),ylabel('rin,yout');
 grid on
 title('GAÓÅ»¯½×Ô¾ÏìÓ¦Êä³öÇúÏß')
 hold off
 
 figure(2)
 plot(time,error,'b','LineWidth',3)
 xlabel('time(s)'),ylabel('rin,error');
 grid on
 title('GAÓÅ»¯½×Ô¾ÏìÓ¦Îó²îÇúÏß')