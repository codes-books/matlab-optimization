%x1(时间),y1、y2、y3、y4、y5、y6（分类后的食品的物价）均在Matlab中的workplace中载入；
%画出已分类的食品的价格--时间曲线
clc,clear,close all
load('x.mat')
load('y1.mat')
%蔬菜类食品的增长率图
for i=1:38
   for j=1:15
      z444 (i,j)=z44(i,j)/z4(i,j);
   end
end
for i=1:15
   subplot(4,4,i);
   plot(x1,z444(:,i) ,x2,0.03*ones(1,39),'r--',x2,-0.03*ones(1,39),'r--',x2,0.05*ones(1,39) ,'r--',x2,-0.05*ones(1,39) ,'r--');hold on
end
