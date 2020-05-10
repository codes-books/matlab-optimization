clc% 清屏
clear all;%删除workplace变量
close all;%关掉显示图形窗口
%%
x=[0.6,0.67,0.6];
ca=[0.1,0.335,0.1];  % 标准区间的中值
ca1=x-ca./sqrtm((-log(0.1)))  %delta
%%
x=0:0.1:1;
w1=1-exp(-((x-ca(1,1))/ca1(1,1)).^2);
w2=1-exp(-((x-ca(1,2))/ca1(1,2)).^2);
w3=1-exp(-((x-ca(1,3))/ca1(1,3)).^2);
plot(x,w1,'r','linewidth',2)
hold on
plot(x,w2,'g','linewidth',2)
plot(x,w3,'b','linewidth',2)
grid on
legend('SO2','NO2','PM10')
