function BsJ=PID_SOA(Kpidi)
ts=0.001;
sys=tf([1.6],[1 1.5 1.6],'inputdelay',0.1);
dsys=c2d(sys,ts,'z');
[num,den]=tfdata(dsys,'v');
u_1=0.0;u_2=0.0;
y_1=0.0;y_2=0.0;
x=[0,0,0]';
B=0;
error_1=0;
tu=1;
s=0;
P=100;
for k=1:1:P
    timef(k)=k*ts;
    r(k)=1;
    u(k)=Kpidi(1)*x(1)+Kpidi(2)*x(3)+Kpidi(3)*x(2);
    if u(k)>=10
        u(k)=10;
    end
    if u(k)<=-10
        u(k)=-10;
    end
    yout(k)=-den(2)*y_1-den(3)*y_2+num(2)*u_1+num(3)*u_2;
    error(k)=r(k)-yout(k);
    %Return of PID parameters
    u_2=u_1;u_1=u(k);
    y_2=y_1;y_1=yout(k);
    x(1)=error(k);                % Calculating  P
    x(2)=(error(k)-error_1)/ts;   %          D
    x(3)=x(3)+error(k)*ts;        %           I 
    error_2=error_1;
    error_1=error(k);
    if s==0
        if yout(k)>0.95&yout(k)<1.05
            tu=timef(k);
            s=1;
        end
    end
end
for i=1:1:P
    Ji(i)=0.999*abs(error(i))+0.01*u(i)^2*0.1;
    B=B+Ji(i);
    if i>1
        erry(i)=yout(i)-yout(i-1);
        if erry(i)<0
            B=B+100*abs(erry(i));
        end
    end
end
BsJ=B+0.2*tu*10;