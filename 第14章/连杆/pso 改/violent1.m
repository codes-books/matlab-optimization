function result=violent1(x)
qb=1;
jj=5;
gamn=45*pi/180;
g(1)=x(1)^2+x(2)^2-(jj-qb)^2-2*x(1)*x(2)*cos(gamn);   % ��С������Լ������
result=min(g(1));