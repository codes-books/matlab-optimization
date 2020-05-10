clc % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口
format short
load('mydata.mat')
figure,
bar(xishu')
axis tight
hold on
annotation('textbox',[0.26 0.14 0.086 0.07],'String',{'单杠'},'FitBoxToText','off');
annotation('textbox',[0.56 0.14 0.086 0.07],'String',{'弯曲'},'FitBoxToText','off');
annotation('textbox',[0.76 0.14 0.086 0.07],'String',{'跳高'},'FitBoxToText','off');

ch0=repmat(ch0,num,1);
yhat=ch0+x0*xish; %计算y 的预测值
y1max=max(yhat);
y2max=max(y0);
ymax=max([y1max;y2max])
cancha=yhat-y0; %计算残差
figure,
subplot(2,2,1)
plot(0:ymax(1),0:ymax(1),yhat(:,1),y0(:,1),'*')
title('单杠成绩预测')
subplot(2,2,2)
plot(0:ymax(2),0:ymax(2),yhat(:,2),y0(:,2),'O')
title('弯曲成绩预测')
subplot(2,1,2)
plot(0:ymax(3),0:ymax(3),yhat(:,3),y0(:,3),'H')
title('跳高成绩预测')
