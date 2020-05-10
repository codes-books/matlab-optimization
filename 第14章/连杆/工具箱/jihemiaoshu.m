% 按等间隔矢量产生二维网格矩阵
xx1=linspace(0,10,40);
xx2=linspace(0,10,40);
[x1,x2]=meshgrid(xx1,xx2);
% 数学模型
%目标函数

%约束函数
qb=1;jj=5;
gamn=45*pi/180;
g1=x1^2+x2^2-(jj-qb)^2-2*x1*x2*cos(gamn);   % 最小传动角约束
g2=-x1^2-x2^2+(jj+qb)^2-2*x1*x2*cos(gamn);  % 最大传动角约束
% 设计平面
figure(1);
h=contour(x1,x2,g1);
clabel(h);
h=contour(x1,x2,g2);
clabel(h);
axis equal                     % 两坐标轴的定标因子相等
title('\bf 设计平面');
xlabel('设计变量 \bf X1');
ylabel('设计变量 \bf X2');







