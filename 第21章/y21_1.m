% kalman filter
clc% ����
clear all;%ɾ��workplace����
close all;%�ص���ʾͼ�δ���
N=300; %���ݵ�
CON = 25; %�㶨��
%kalman filter
x = zeros(1,N);
y = 2^0.5 * randn(1,N) + CON; % �ӹ���������״̬���
figure(1);
hist(y);% ���������ź�ֱ��ͼ
x(1) = 1;
p = 10;% ��ʼЭ����
Q = cov(randn(1,N)); % ��������Э����-Ԥ��ֵ
R = cov(randn(1,N)); % �۲�����Э����-����ֵ
for k = 2 : N
    x(k) = x(k - 1);%Ԥ����kʱ��״̬������ֵ
    p = p + Q;%��Ӧ��Ԥ��ֵ��Э����
    kg = p / (p + R);%kalman ����
    x(k) = x(k) + kg * (y(k) - x(k));% ���ſ�����
    p = (1 - kg) * p; % ���ſ���ֵ��Э����
end

%Smoothness Filter
Filter_Wid = 10;
smooth_res = zeros(1,N);
for i = Filter_Wid + 1 : N
    tempsum = 0;
    for j = i - Filter_Wid : i - 1
        tempsum = tempsum + y(j);
    end
    smooth_res(i) = tempsum / Filter_Wid;  % ÿ��10����ȡһ��ƽ��ֵ
end
% ��ʼֵ����ͼʹ��
t=1:N;
expValue = zeros(1,N);
for i = 1: N
    expValue(i) = CON; % ԭʼ�㶨�趨ֵ
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
