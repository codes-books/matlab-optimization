clc,clear
load('yx.mat') %原始数据以列向量的方式存放
yt=yx; n=length(yt);
alpha=[0.1 0.3 0.9];m=length(alpha);
yhat(1,1:m)=(yt(1)+yt(2))/2;
for i=2:n
    yhat(i,:)=alpha*yt(i-1)+(1-alpha).*yhat(i-1,:);
end
yhat;%预测值
err=sqrt(mean((repmat(yt,1,m)-yhat).^2))%预测误差总和
yhat114=alpha*yt(n)+(1-alpha).*yhat(n,:) %预测下一时刻值
