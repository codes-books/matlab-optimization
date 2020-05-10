function y3_2
    t0=0;
    tf=6;
    a=9.8; %初始加速度
    options =odeset('RelTol',1e-4,'AbsTol',[1e-4]);
    [T,V]=ode45(@diffv,[t0 tf],a,options);     % /用低阶法求微分方程二的数值解/
    plot(T,V)
    axis tight
    grid on
    xlabel('t');
    ylabel('v');
end

function dv = diffv(t,v)  %/*第二个微分方程*/
    m=1.1;
    k1=0.1;k2=0.2;
    g=9.8;
    dv=zeros(1,1);
    dv(1)=(m*g-k1*v(1)*v(1)-k2*v(1))/m;
end