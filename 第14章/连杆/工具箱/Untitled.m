% 按等间隔矢量产生二维网格矩阵
xx1=linspace(0,10,40);
xx2=linspace(0,10,40);
[x1,x2]=meshgrid(xx1,xx2);
% 数学模型
%目标函数
f=0.02.*x1.*sqrt(x2);
% 目标函数值几何描述
fh=contour(x1,x2,f);                             % 目标函数等高线
clabel(fh);                                      % 标注目标函数值
title('\bf 优化设计平面');
xlabel('x1 ');
ylabel('x2 ');
%约束函数
qb=1;jj=5;
gamn=45*pi/180;
g1=x1^2+x2^2-(jj-qb)^2-2*x1*x2*cos(gamn);   % 最小传动角约束
g2=-x1^2-x2^2+(jj+qb)^2-2*x1*x2*cos(gamn);  % 最大传动角约束
% 约束函数几何描述
hold on;
g1h=contour(x1,x2,g1);
g2h=contour(x1,x2,g2);
