clc,clear
load('yx.mat') %ԭʼ�������������ķ�ʽ���
yt=yx; n=length(yt);
alpha=[0.1 0.3 0.9];m=length(alpha);
yhat(1,1:m)=(yt(1)+yt(2))/2;
for i=2:n
    yhat(i,:)=alpha*yt(i-1)+(1-alpha).*yhat(i-1,:);
end
yhat;%Ԥ��ֵ
err=sqrt(mean((repmat(yt,1,m)-yhat).^2))%Ԥ������ܺ�
yhat114=alpha*yt(n)+(1-alpha).*yhat(n,:) %Ԥ����һʱ��ֵ
