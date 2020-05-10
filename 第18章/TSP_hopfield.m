%% 连续Hopfield神经网络的优化—旅行商问题优化计算
% function TSP_hopfield()
%% 清空环境变量、定义全局变量
clc % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口
% step 1
A=1.5;
D=1;
u0=0.02;
step=0.01;
% step 2
N=8;
citys=[0.1,0.1;0.9,0.5;0.9,0.1;0.45,0.9;0.9,0.8;0.7,0.9;0.1,0.45;0.45,0.1];
Initial_Length=Initial_RouteLength(citys);        % 计算初始路径长度
DistanceCity=dist(citys,citys');
% step 3
u=2*rand(N,N)-1;
U=0.5*u0*log(N-1)+u;
V=(1+tanh(U/u0))/2;

for k=1:1:2000
    times(k)=k;
%     step 4
    dU=DeltaU(V,DistanceCity,A,D);
%     step 5
    U=U+dU*step;
%     step 6
    V=(1+tanh(U/u0))/2;
%     step 7 计算能量函数
    E=Energy(V,DistanceCity,A,D);
    Ep(k)=E;
%     step 8 检查路径合法性
    [V1,CheckR]=RouteCheck(V);
end

% step 9
if (CheckR==0)
    Final_E=Energy(V1,DistanceCity,A,D);
    Final_Length=Final_RouteLength(V1,citys);       % 计算最终路径长度
    disp('迭代次数');k
    disp('寻优路径矩阵：');V1
    disp('最优能量函数：');Final_E
    disp('初始路程：');Initial_Length
    disp('最短路程：');Final_Length
    PlotR(V1,citys);    % 寻优路径作图
else
    disp('寻优路径无效');
end

figure(2);
plot(times,Ep,'r','linewidth',2);
title('能量函数变化');
xlabel('k');
ylabel('E');
grid on

