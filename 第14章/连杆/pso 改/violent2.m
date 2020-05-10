function result=violent2(x)
qb=1;
jj=5;
gamn=45*pi/180;
g(2)=-x(1)^2-x(2)^2+(jj+qb)^2-2*x(1)*x(2)*cos(gamn);  % 最大传动角约束函数
result=min(g(2));