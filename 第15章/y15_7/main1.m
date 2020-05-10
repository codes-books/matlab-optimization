%��������Ⱥ�㷨 ��particle swarm optimization��
%��ʼ��
clear all;              %������б���
clc;                    %����
format long;            %��������ʾΪ�����ο�ѧ����
%------������ʼ������------------------
N=40;                   %?��ʼ��Ⱥ�����
D=10;                   %��ʼ��Ⱥ��ά��
T=100;                 %��ʼ��Ⱥ�����������
c11=2;                   %ѧϰ����1
c21=2;                   %ѧϰ����2
c12=1.5;
c22=1.5;
w=1.2;                  %����Ȩ��
eps=10^(-6);            %���þ��ȣ�����֪��Сֵ��ʱ���ã�
%------��ʼ����Ⱥ���壨�޶�λ�ú��ٶȣ�------------
x=zeros(N,D);
v=zeros(N,D);
for i=1:N
    for j=1:D
        x(i,j)=randn;   %�����ʼ��λ��
        v(i,j)=randn;   %�����ʼ���ٶ�
    end
end


figure(1)
%��һ��ͼ
subplot(1,2,1)
%------��ʼ����Ⱥ���壨�ڴ��޶��ٶȺ�λ�ã�------------
x1=x;
v1=v;
%------��ʼ����������λ�ú�����ֵ---
p1=x1;
pbest1=ones(N,1);
for i=1:N
    pbest1(i)=fitness(x1(i,:),D);
end
%------��ʼ��ȫ������λ�ú�����ֵ---------------
g1=1000*ones(1,D);
gbest1=1000;
for i=1:N
    if(pbest1(i)<gbest1)
        g1=p1(i,:);
        gbest1=pbest1(i);
    end
end
gb1=ones(1,T);
%-----������ѭ�������չ�ʽ���ε���ֱ�����㾫�Ȼ��ߵ�������---
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
xlabel('��������');
ylabel('��Ӧ��ֵ');
%�ڶ���ͼ
subplot(1,2,2)
%-----��ʼ����Ⱥ���壨�ڴ��޶��ٶȺ�λ�ã�------------
x2=x;
v2=v;
%-----��ʼ����Ⱥ��������λ�ú� ���Ž�-----------
p2=x2;
pbest2=ones(N,1);
for i=1:N
    pbest2(i)=fitness(x2(i,:),D);
end
%-----��ʼ����ȫ������λ�ú� ���Ž�------
g2=1000*ones(1,D);
gbest2=1000;
for i=1:N
    if(pbest2(i)<gbest2)
        g2=p2(i,:);
        gbest2=pbest2(i);
    end
end
gb2=ones(1,T);
%------������ѭ�������չ�ʽ���ε���ֱ�����㾫�Ȼ��ߵ�������---
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
xlabel('��������');
ylabel('��Ӧ��ֵ');

