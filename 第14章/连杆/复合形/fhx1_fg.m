% 复合形法二维约束优化问题的数学模型
function [f,g1,g2]=fhx1_fg(x1,x2)
s=50;
qb=1;
jj=5;
fx=0;
g1=-x1^2-x2^2+(jj-qb)^2+2*x1*x2*cos(45*pi/180);  
g2=x1^2+x2^2+(jj+qb)^2-2*x1*x2*cos(45*pi/180);
fa0=acos(((qb+x1)^2-x2^2+jj^2)/(2*(qb+x1)*jj));     % 曲柄初始角
pu0=acos(((qb+x1)^2-x2^2-jj^2)/(2*x2*jj));          % 摇杆初始角
for i=1:s
    fai=fa0+0.5*pi*i/s;        % 曲柄实际位置角                           
    pui=pu0+2*(fai-fa0)^2/(3*pi);  %摇杆期望输出角
    ri=sqrt(qb^2+jj^2-2*qb*jj*cos(fai)); %辅助线BD长度
    alfi=acos((ri^2+x2^2-x1^2)/(2*ri*x2)); %L3与ri的夹角αi
    bati=acos((ri^2+jj^2-qb^2)/(2*ri*jj));%ri和L4的夹角βi
    ps=pi-alfi-bati; 
     fx=fx+(pui-ps)^2;                  % 输出角平方误差之和
end
f=fx;

