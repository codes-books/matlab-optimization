clc % ����
clear all; % ɾ��workplace����
close all; % �ص���ʾͼ�δ���
format short
load('mydata.mat')
figure,
bar(xishu')
axis tight
hold on
annotation('textbox',[0.26 0.14 0.086 0.07],'String',{'����'},'FitBoxToText','off');
annotation('textbox',[0.56 0.14 0.086 0.07],'String',{'����'},'FitBoxToText','off');
annotation('textbox',[0.76 0.14 0.086 0.07],'String',{'����'},'FitBoxToText','off');

ch0=repmat(ch0,num,1);
yhat=ch0+x0*xish; %����y ��Ԥ��ֵ
y1max=max(yhat);
y2max=max(y0);
ymax=max([y1max;y2max])
cancha=yhat-y0; %����в�
figure,
subplot(2,2,1)
plot(0:ymax(1),0:ymax(1),yhat(:,1),y0(:,1),'*')
title('���ܳɼ�Ԥ��')
subplot(2,2,2)
plot(0:ymax(2),0:ymax(2),yhat(:,2),y0(:,2),'O')
title('�����ɼ�Ԥ��')
subplot(2,1,2)
plot(0:ymax(3),0:ymax(3),yhat(:,3),y0(:,3),'H')
title('���߳ɼ�Ԥ��')
