% TSP����Ⱥ��������Ⱥ�㷨program
function y20_2
clc % ����
clear all; % ɾ��workplace����
close all; % �ص���ʾͼ�δ���

% ����ÿ�ε��������Ž�
% ��max(t^a*d^(-b))Ϊ����������·�����뱣��������·���Ƚ�
x=[41,37,54,25,7,2,68,71,54,83,64,18,22,83,91,...
    25,24,58,71,74,87,18,13,82,62,58,45,41,44,4];
y=[94,84,67,62,64,99,58,44,62,69,60,54,60,46,38,...
    38,42,69,71,78,76,40,40,7,32,35,21,26,35,50];
n=30;% n��ʾ������Ŀ
c=100;
q=10^(+6);
NC=50;
r=0.9;% r��ʾ�켣�־���
a=1.5;% a��ʾ�켣�����Ҫ��
b=2;% b��ʾ�ܼ��������Ҫ��
m=30;% m��ʾ������Ŀ
for i=1:n
    for j=1:n
        dij(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);%����
    end
end
for i=1:n
    dij(i,i)=0.01;
end

min10=10^5;
t=ones(n)*c;
for i=1:100
    road(i,:)=randperm(n);
    ltspc(i)=ca_tsp(n,road(i,:),dij);
end

ltspsort=sort(ltspc);
l30=ltspsort(m);%ѡ��m����ʼ��,mֻ����
i1=0;
for i=1:100
    if ltspc(i)<=1300
        for k=1:n-1
            t(road(i,k),road(i,k+1))=t(road(i,k),road(i,k+1))+10;
            t(road(i,k+1),road(i,k))=t(road(i,k),road(i,k+1));
        end
        t(road(i,1),road(i,n))=t(road(i,1),road(i,n))+10;
        t(road(i,n),road(i,1))=t(road(i,1),road(i,n));    
        i1=i1+1;
        pcbest(i1,:)=road(i,:);%��ʼpcbest·������
        plbest(i1)=ltspc(i);%��ʼplbest��·��
    end
end

[glbest,j]=min(plbest);%��ʼglbest·������
gcbest=pcbest(j,:);%��ʼgcbest·��
for nc=1:NC 
    
    tabu=ones(m,n);%���ɱ�
    tabu(:,1)=0;
    path=ones(m,n);
    for k=1:m
        for step=1:n-1
            ta=t.^a;
            tb=dij.^(-b);
            td=ta.*tb;
            pd=tabu(k,:).*td(path(k,step),:);
            pk=pd/sum(pd);%����
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
    
     for i=1:m
        ltsp(i)=ca_tsp(n,path(i,:),dij);
        %�������
        % ���ֽ����ӳ���ֱ�Ϊcross_tsp_a,cross_tsp_b,cross_tsp_c,cross_tsp_d
        path1(i,:)=cross_tsp_d(path(i,:),gcbest,n);
        path1(i,:)=cross_tsp_d(path1(i,:),pcbest(i,:),n);
        %�������
        %���ֱ����ӳ���ֱ�Ϊmutation_a,mutation_b,mutation_c,mutation_d
        path1(i,:)=mutation_d(path1(i,:),n);
        % ������·������֮��
        ltsp1(i)=ca_tsp(n,path1(i,:),dij);
        %����弫ֵ
        if ltsp1(i)<ltsp(i)
            ltsp(i)=ltsp1(i);
            path(i,:)=path1(i,:);
        end
        if ltsp(i)<plbest(i)
            plbest(i)=ltsp(i);
            pcbest(i,:)=path(i,:);
        end
     end
     
     %��ȫ�ּ�ֵ
     [glbest,j]=min(plbest);
     gcbest=pcbest(j,:);
     dt=zeros(n);
     for i=1:m
        for k=1:n-1
            dt(path(i,k),path(i,k+1))=dt(path(i,k),path(i,k+1))+q/ltsp(i);
            dt(path(i,k+1),path(i,k))=dt(path(i,k),path(i,k+1));
        end
        dt(path(i,n),path(i,1))=dt(path(i,n),path(i,1))+q/ltsp(i);
        dt(path(i,1),path(i,n))=dt(path(i,n),path(i,1)); 
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
if glbest<ltsp0
    ts=gcbest;
    ltsp0=glbest;
end

k=1;
while k<=n;
    x1(k)=x(ts(k));
    y1(k)=y(ts(k));
    k=k+1;
end

x1(n+1)=x1(1);
y1(n+1)=y1(1);
%����ͼ��
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
% ����·������
function ltsp=ca_tsp(n,c,dij)
i=1;
ltsp=dij(c(n),c(1));
while i<n;
    ltsp=ltsp+dij(c(i),c(i+1));
    i=i+1;
end
end

        


