% 连杆机构实现函数优化的目标函数(jfg_f)
function f=jfg_f(x);
s=30;qb=1;jj=5;fx=0;
fa0=acos(((qb+x(1))^2-x(2)^2+jj^2)/(2*(qb+x(1))*jj));     % 曲柄初始角
pu0=acos(((qb+x(1))^2-x(2)^2-jj^2)/(2*x(2)*jj));          % 摇杆初始角
for i=1:s
    fai=fa0+0.5*pi*i/s;
    pui=pu0+2*(fai-fa0)^2/(3*pi);
    ri=sqrt(qb^2+jj^2-2*qb*jj*cos(fai));
    alfi=acos((ri^2+x(2)^2-x(1)^2)/(2*ri*x(2)));
    bati=acos((ri^2+jj^2-qb^2)/(2*ri*jj));
    if fai>0 & fai<=pi
        psi=pi-alfi-bati;
    elseif  fai>pi & fai<=2*pi
        psi=pi-alfi+bati;
    end
    fx=fx+(pui-psi)^2;                            % 输出角平方误差之和
end
f=fx;