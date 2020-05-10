% kalman filter
clc% 清屏
clear all;%删除workplace变量
close all;%关掉显示图形窗口
N=300; %数据点
CON = 25; %恒定量
%kalman filter
x = zeros(1,N);
y = 2^0.5 * randn(1,N) + CON; % 加过程噪声的状态输出
figure(1);
hist(y);% 加噪音后信号直方图
x(1) = 1;
p = 10;% 初始协方差
Q = cov(randn(1,N)); % 过程噪声协方差-预测值
R = cov(randn(1,N)); % 观测噪声协方差-测量值
for k = 2 : N
    x(k) = x(k - 1);%预估计k时刻状态变量的值
    p = p + Q;%对应于预估值的协方差
    kg = p / (p + R);%kalman 增益
    x(k) = x(k) + kg * (y(k) - x(k));% 最优控制量
    p = (1 - kg) * p; % 最优控制值的协方差
end

%Smoothness Filter
Filter_Wid = 10;
smooth_res = zeros(1,N);
for i = Filter_Wid + 1 : N
    tempsum = 0;
    for j = i - Filter_Wid : i - 1
        tempsum = tempsum + y(j);
    end
    smooth_res(i) = tempsum / Filter_Wid;  % 每隔10个点取一次平均值
end
% 初始值供画图使用
t=1:N;
expValue = zeros(1,N);
for i = 1: N
    expValue(i) = CON; % 原始恒定设定值
end
figure(2);
plot(t,expValue,'r',t,y,'b');
axis([0 N 20 30])
xlabel('Sample time');
ylabel('Room Temperature');
grid on
title('actual signal VS signal+white noise')
legend('expected','measure');

figure(3);
plot(t,smooth_res,'k',t,x,'g','LineWidth',2);
legend('smooth result','Kalman estimate');
axis([0 N 20 30])
xlabel('Sample time');
ylabel('Room Temperature');
grid on
title('Smooth filter VS kalman filter')
