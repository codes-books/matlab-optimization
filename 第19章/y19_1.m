% TSP的蚁群算法program
function y20_1
clc % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口

% 保留每次迭代的最优解
% 以max(t^a*d^(-b))为依据找最优路劲，与保留的最优路劲比较
x=[41,37,54,25,7,2,68,71,54,83,64,18,22,83,91,...
    25,24,58,71,74,87,18,13,82,62,58,45,41,44,4];
y=[94,84,67,62,64,99,58,44,62,69,60,54,60,46,38,...
    38,42,69,71,78,76,40,40,7,32,35,21,26,35,50];
n=30;% n表示城市数目
c=100;
q=10^(+6);
NC=50;
r=0.9;% r表示轨迹持久性
a=1.5;% a表示轨迹相对重要性
b=2;% b表示能见度相对重要性
m=30;% m表示蚂蚁数目
for i=1:n
    for j=1:n
        dij(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);%距离
    end
end
for i=1:n
    dij(i,i)=0.01;
end

min10=10^5;
t=ones(n)*c;
for nc=1:NC 
    
    tabu=ones(m,n);%禁忌表
    tabu(:,1)=0;
    path=ones(m,n);
    for k=1:m
        for step=1:n-1
            ta=t.^a;
            tb=dij.^(-b);
            td=ta.*tb;
            pd=tabu(k,:).*td(path(k,step),:);
            pk=pd/sum(pd);%概率
            rk=rand;
            spk=0;
            j=1;
            while j<=n;
                if rk<spk+pk(j)
                    break;
                else 
                    spk=spk+pk(j);
                    j=j+1;
                end
            end
            tabu(k,j)=0;
            path(k,step+1)=j;
        end
    end
    
    dt=zeros(n);
    for i=1:m
        ltsp(i)=ca_tsp(n,path(i,:),dij);
        for k=1:n-1
            dt(path(i,k),path(i,k+1))=dt(path(i,k),path(i,k+1))+q/ltsp(i);
            dt(path(i,k+1),path(i,k))=dt(path(i,k),path(i,k+1));
        end
        dt(path(i,n),path(i,1))=dt(path(i,n),path(i,1));
        dt(path(i,1),path(i,n))=dt(path(i,n),path(i,1)); 
    end
    
    [min1,i]=min(ltsp);
    if min1<min10;
        min10=min1;
        c0=path(i,:);
    end
    
    t=r*t+dt;
end
%%
ta=t.^a;
tb=dij.^(-b);
td=ta.*tb;
k=3;
ts(1)=1;
td(:,1)=0;
[my,i]=max(td(1,:));
ts(2)=i;
td(:,i)=0;
while k<=n
    [my,i]=max(td(i,:));
    ts(k)=i;
    td(:,i)=0; 
    k=k+1;
end
ts;
ltsp0=ca_tsp(n,ts,dij);
if min10<ltsp0
    ts=c0;
    ltsp0=min10;
end
k=1;
while k<=n;
    x1(k)=x(ts(k));
    y1(k)=y(ts(k));
    k=k+1;
end
x1(n+1)=x1(1);
y1(n+1)=y1(1);
%绘制图形
figure(1),
plot(x,y,'o--');
grid on

figure(2),
line(x1,y1,'color','r','linewidth',2);
hold on
plot(x,y,'o--');
grid on
[x1',y1']
ltsp0
end

% ca_tsp.m
% 计算路径长度
function ltsp=ca_tsp(n,c,dij)
i=1;
ltsp=dij(c(n),c(1));
while i<n;
    ltsp=ltsp+dij(c(i),c(i+1));
    i=i+1;
end
end
