clc,clear,close all
k=3;alpha=1.3;          % 复合形顶点数和映射系数
disp '        数学模型:'
syms x1 x2
[f,g1,g2]=fhx1_fg(x1,x2);
pretty(f);
pretty(g1);
pretty(g2);
% 初始复合形计算
x01=[4 2];x02=[2 1];x03=[2 3];
disp '    复合形顶点的目标函数和约束函数值 '
x1=x01(1);x2=x01(2);[f1,g11,g12]=fhx1_fg(x1,x2);
x1=x02(1);x2=x02(2);[f2,g21,g22]=fhx1_fg(x1,x2);
x1=x03(1);x2=x03(2);[f3,g31,g32]=fhx1_fg(x1,x2);
disp '     f    g1    g2   '
D1=[f1,g11,g12]
D2=[f2,g21,g22]
D3=[f3,g31,g32]
%---判定初始复合形各顶点是可行点
[H,L]=fhx2_HL(f1,f2,f3);
%---判定初始复合形的坏点-2
disp '    复合形(去掉坏点)几何中心和映射点'
disp '  几何中心'
xc1=(x01+x03)/(k-1)
disp '  映射点'
xr1=xc1+alpha*(xc1-x02)
% 构成新复合形(1)
x1=xr1(1);x2=xr1(2);[fr1,gr11,gr12]=fhx1_fg(x1,x2);
disp '       新1复合形的计算'
disp '     f         g1         g2       '
Dr=[fr1,gr11,gr12]
%---判定映射点是可行点
if fr1<f2
f2=fr1;x02=xr1;    % 将函数值较小的映射点替换初始复合形的坏点-2
end
x1=x01(1);x2=x01(2);[f1,g11,g12]=fhx1_fg(x1,x2);
x1=x03(1);x2=x03(2);[f3,g31,g32]=fhx1_fg(x1,x2);
D1=[f1,g11,g12]
D3=[f3,g31,g32]
[H,L]=fhx2_HL(f1,f2,f3);
%---判定新复合形(1)各顶点是可行点
%---判定新复合形(1)的坏点-1
disp '  几何中心'
xc2=(x03+x01)/(k-1)
disp '  映射点'
xr2=xc2+alpha*(xc2-x02)
x1=xr2(1);x2=xr2(2);[fr2,gr21,gr22]=fhx1_fg(x1,x2);
disp '       新2复合形的计算'
disp '     f         g1         g2       '
Dr=[fr2,gr21,gr22]
% 由于g1(xr2)<0，将映射系数减半后重新计算映射点
alpha=0.65;
xr3=xc2+alpha*(xc2-x02)
x1=xr3(1);x2=xr3(2);[fr3,gr31,gr32]=fhx1_fg(x1,x2);
disp '     f         g1         g2       '
Dr=[fr3,gr31,gr32]
%---判定射系数减半后新映射点是可行点
if fr3<f1
f1=fr3;
x01=xr3;    % 将函数值较小的映射点替换新复合形(1)的坏点-1
end
% 构成新复合形(2)
[H,L]=fhx2_HL(f1,f2,f3);
% 新复合形(2)的好点-1
disp '         最优点        函数值'
[x01,f1]
