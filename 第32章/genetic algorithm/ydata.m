clc,clear,close all
load('data1.mat')
figure(1),
plot(y)
hold on
plot(yc,'ro--','linewidth',2)
grid on
axis tight
legend('ԭʼ����','Ԥ������')
figure(2),
plot(y-yc,'ro--','linewidth',2)
title('�������')
grid on
axis tight