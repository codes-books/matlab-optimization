clc,clear,close all
load('data1.mat')
figure(1),
plot(y)
hold on
plot(yc,'ro--','linewidth',2)
grid on
axis tight
legend('原始数据','预测数据')
figure(2),
plot(y-yc,'ro--','linewidth',2)
title('误差数据')
grid on
axis tight