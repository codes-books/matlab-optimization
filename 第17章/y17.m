%TSP_GA Traveling Salesman Problem (TSP) Genetic Algorithm (GA)
clc % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口

n = 50;%城市的数量
xy = 10*rand(n,2);%城市的位置坐标
popSize = 60;%种群的大小，一般被4整除
numIter = 1e4;%算法迭代的次数
showProg = 1;%如果满足条件，执行遗传算法的步骤
showResult = 1;%如果满足条件，执行遗传算法的结果
a = meshgrid(1:n);
dmat = reshape(sqrt(sum((xy(a,:)-xy(a',:)).^2,2)),n,n);%城市之间的距离/成本
[optRoute,minDist] = tsp_ga(xy,dmat,popSize,numIter,showProg,showResult);
%% Output:
% optRoute 遗传算法得出的最优路径
% minDist 最优路径下的成本值或距离值
%%
figure,
for i=1:n
    hold on
    plot(xy(:,1),xy(:,2),'k.');
    text(xy(i,1),xy(i,2)+0.08,num2str(i));
end
for i=1:n-1
    plot([xy(optRoute(1,i),1),xy(optRoute(1,i+1),1)],[xy(optRoute(1,i),2),xy(optRoute(1,i+1),2)])
    hold on
end
for i=n
    plot([xy(optRoute(1,i),1),xy(optRoute(1,1),1)],[xy(optRoute(1,i),2),xy(optRoute(1,1),2)])
    hold on
end
