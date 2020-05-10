%% 患者癌症和正常样本SOM分类
clc % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口
format short
% Initial

%% 录入输入数据
% 载入数据并将数据分成训练和预测两类
load gene.mat;
data=gene;
P=data(1:40,:); % 前20个是癌症，后20个是正常样本
T=data(41:60,:); % 待检测样本

% 转置后符合神经网络的输入格式
P=P';
T=T';
% 归一化操作
[Pn,Ps]=mapminmax(P);
[Tn,Ts]=mapminmax(T);
% 取输入元素的最大值和最小值Q：
% Q=minmax(P);
Q=minmax(Pn);

%% 网络建立和训练
% 利用newc( )命令建立竞争网络：
% Q为训练数据最大最小值
% 2代表竞争层的神经元个数，也就是要分类的个数
% 0.1代表学习速率
net=newc(Q,2,0.1)

% 初始化网络及设定网络参数：
net=init(net); 
% 训练迭代次数
net.trainparam.epochs=200;
% 训练网络：
% net=train(net,P);
net=train(net,Pn)

%% 网络的效果验证

% 将原数据回带，测试网络效果：
% a=sim(net,P);
a=sim(net,Pn);
% 使用变换函数vec2ind()，将单值向量组变换成下标向量
% a：为n个元素值为1所在的行下标值构成的一个行向量。
% ac：为m行n列的向量矩阵x，x中的每个列向量i，除包含一个1外，其余元素均为0。
ac=vec2ind(a) % 分类标记

%% 网络作分类的预测
% 下面将后20个数据带入神经网络模型中，观察网络输出：
% sim( )来做网络仿真
% Y=sim(net,T)
Y=sim(net,Tn)
% 得到预测的可能性结果
Yc=vec2ind(Y)

