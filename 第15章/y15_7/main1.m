%基本粒子群算法 （particle swarm optimization）
%初始化
clear all;              %清除所有变量
clc;                    %清屏
format long;            %将数据显示为长整形科学计数
%------给定初始条条件------------------
N=40;                   %?初始化群体个数
D=10;                   %初始化群体维数
T=100;                 %初始化群体最迭代次数
c11=2;                   %学习因子1
c21=2;                   %学习因子2
c12=1.5;
c22=1.5;
w=1.2;                  %惯性权重
eps=10^(-6);            %设置精度（在已知最小值的时候用）
%------初始化种群个体（限定位置和速度）------------
x=zeros(N,D);
v=zeros(N,D);
for i=1:N
    for j=1:D
        x(i,j)=randn;   %随机初始化位置
        v(i,j)=randn;   %随机初始化速度
    end
end


figure(1)
%第一个图
subplot(1,2,1)
%------初始化种群个体（在此限定速度和位置）------------
x1=x;
v1=v;
%------初始化个体最优位置和最优值---
p1=x1;
pbest1=ones(N,1);
for i=1:N
    pbest1(i)=fitness(x1(i,:),D);
end
%------初始化全局最优位置和最优值---------------
g1=1000*ones(1,D);
gbest1=1000;
for i=1:N
    if(pbest1(i)<gbest1)
        g1=p1(i,:);
        gbest1=pbest1(i);
    end
end
gb1=ones(1,T);
%-----浸入主循环，按照公式依次迭代直到满足精度或者迭代次数---
for i=1:T
    for j=1:N
        if (fitness(x1(j,:),D)<pbest1(j))
            p1(j,:)=x1(j,:);
            pbest1(j)=fitness(x1(j,:),D);
        end
        if(pbest1(j)<gbest1)
            g1=p1(j,:);
            gbest1=pbest1(j);
        end
        v1(j,:)=w*v1(j,:)+c11*rand*(p1(j,:)-x1(j,:))+c21*rand*(g1-x1(j,:));
        x1(j,:)=x1(j,:)+v1(j,:);       
    end
    gb1(i)=gbest1;
end
plot(gb1,'r--','linewidth',2)
TempStr=sprintf('c1= %g ,c2=%g',c11,c21);
title(TempStr);
grid on
xlabel('迭代次数');
ylabel('适应度值');
%第二个图
subplot(1,2,2)
%-----初始化种群个体（在此限定速度和位置）------------
x2=x;
v2=v;
%-----初始化种群个体最有位置和 最优解-----------
p2=x2;
pbest2=ones(N,1);
for i=1:N
    pbest2(i)=fitness(x2(i,:),D);
end
%-----初始化种全局最有位置和 最优解------
g2=1000*ones(1,D);
gbest2=1000;
for i=1:N
    if(pbest2(i)<gbest2)
        g2=p2(i,:);
        gbest2=pbest2(i);
    end
end
gb2=ones(1,T);
%------浸入主循环，按照公式依次迭代直到满足精度或者迭代次数---
for i=1:T
    for j=1:N
        if (fitness(x2(j,:),D)<pbest2(j))
            p2(j,:)=x2(j,:);
            pbest2(j)=fitness(x2(j,:),D);
        end
        if(pbest2(j)<gbest2)
            g2=p2(j,:);
            gbest2=pbest2(j);
        end
        v2(j,:)=w*v2(j,:)+c12*rand*(p2(j,:)-x2(j,:))+c22*rand*(g2-x2(j,:));
        x2(j,:)=x2(j,:)+v2(j,:);       
    end
    gb2(i)=gbest2;
end
plot(gb2,'r--','linewidth',2)
TempStr=sprintf('c1= %g ,c2=%g',c12,c22);
title(TempStr);
grid on
xlabel('迭代次数');
ylabel('适应度值');

