% 惩罚函数--外点法
% 数学模型
syms x x1 x2
qb=1;
jj=5;
gamn=45*pi/180;
r0 = 0.25;c =2; km = 7;
k = 1:km;              % 迭代计数
r=r0*c.^(k-1);         % 惩罚因子递增数列
x1=4.2-2./(2.*r);
x2=2.4-2./(2.*r);
f=jfg_f1(x);
g1=x1.^2+x2.^2-(jj-qb)^2-2.*x1.*x2.*cos(gamn);   % 最小传动角约束函数
g2=-x1.^2-x2.^2+(jj+qb)^2-2.*x1.*x2.*cos(gamn);  % 最大传动角约束函数     
p=f+r.*g1.^2+r.*g2.^2;           % 惩罚函数p
disp '                 ******    计算结果    ******'
disp '  迭代次数 k'
[k]
disp '  惩罚因子 r'
[r]
disp '  最优点序列 x1*'
[x1]
disp '  最优点序列 x2*'
[x2]
disp   ' 目标函数 f*'
[f]
disp   '  惩罚函数 p*'
[p]    
plot(r,f)
xlabel ('r')
ylabel ('f')
hold on
plot(r,p)
xlabel ('r')
ylabel ('p')