%连杆机构实现函数优化的非线性不等式约束函数(cdj_g)
function [g,ceq]=cdj_g(x);
qb=1;jj=5;
gamn=45*pi/180;
g(1)=x(1)^2+x(2)^2-(jj-qb)^2-2*x(1)*x(2)*cos(gamn);   % 最小传动角约束
g(2)=-x(1)^2-x(2)^2+(jj+qb)^2-2*x(1)*x(2)*cos(gamn);  % 最大传动角约束
ceq=[];
