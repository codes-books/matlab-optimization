clc % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口
format short
% Initial
%% gridtop()网络拓扑结构
pos = gridtop(2,3)
figure,plotsom(pos)
grid on
%% Hextop()函数生成一个六角形形式的拓扑结构
pos = hextop(2,3)
figure,plotsom(pos)
grid on
%% 8*10 神经元拓扑结构来看看六角形神经元拓扑图像
pos = hextop(8,10)
figure,plotsom(pos)
grid on
%% randtop()函数生成的是N维随机形式分布的神经元拓扑结构
pos = randtop(2,3)
figure,plotsom(pos)
grid on
pos = randtop(8,10)
figure,plotsom(pos)
grid on
%% 神经元之间的距离
% dist() ——欧几里得距离
% boxdist()
% mandist()
% 每隔函数代表不同的距离计算方法——神经元与邻近神经元之间的距离
clear
pos = gridtop(2,3)
figure,plotsom(pos)
grid on
d1 = dist(pos)
d2 = boxdist(pos)
d3 = mandist(pos) % 曼哈顿距离











