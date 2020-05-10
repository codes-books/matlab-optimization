clc,clear
load('yx.mat') %原始数据以列向量的方式存放
yt=yx; n=length(yt);
alpha=0.9; st1(1)=yt(1); st2(1)=yt(1);
for i=2:n
    st1(i)=alpha*yt(i)+(1-alpha)*st1(i-1);
    st2(i)=alpha*st1(i)+(1-alpha)*st2(i-1);
end
a=2*st1-st2
b=alpha/(1-alpha)*(st1-st2)
yhat=a+b;
yhat=yhat';
str=char(['C',int2str(n+2)]);
