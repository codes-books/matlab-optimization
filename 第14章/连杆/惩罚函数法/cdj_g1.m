%连杆机构实现函数优化的非线性不等式约束函数(cdj_g)
function [g,ceq]=cdj_g1(x);
syms x1 x2
qb=1;
jj=5;
gamn=45*pi/180;
g1=x1^2+x2^2-(jj-qb)^2-2*x1*x2*cos(gamn);   % 最小传动角约束函数
g2=-x1^2-x2^2+(jj+qb)^2-2*x1*x2*cos(gamn);  % 最大传动角约束函数
ceq=[];%非线性等式约束为空