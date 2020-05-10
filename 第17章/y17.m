%TSP_GA Traveling Salesman Problem (TSP) Genetic Algorithm (GA)
clc % ����
clear all; % ɾ��workplace����
close all; % �ص���ʾͼ�δ���

n = 50;%���е�����
xy = 10*rand(n,2);%���е�λ������
popSize = 60;%��Ⱥ�Ĵ�С��һ�㱻4����
numIter = 1e4;%�㷨�����Ĵ���
showProg = 1;%�������������ִ���Ŵ��㷨�Ĳ���
showResult = 1;%�������������ִ���Ŵ��㷨�Ľ��
a = meshgrid(1:n);
dmat = reshape(sqrt(sum((xy(a,:)-xy(a',:)).^2,2)),n,n);%����֮��ľ���/�ɱ�
[optRoute,minDist] = tsp_ga(xy,dmat,popSize,numIter,showProg,showResult);
%% Output:
% optRoute �Ŵ��㷨�ó�������·��
% minDist ����·���µĳɱ�ֵ�����ֵ
%%
figure,
for i=1:n
    hold on
    plot(xy(:,1),xy(:,2),'k.');
    text(xy(i,1),xy(i,2)+0.08,num2str(i));
end
for i=1:n-1
    plot([xy(optRoute(1,i),1),xy(optRoute(1,i+1),1)],[xy(optRoute(1,i),2),xy(optRoute(1,i+1),2)])
    hold on
end
for i=n
    plot([xy(optRoute(1,i),1),xy(optRoute(1,1),1)],[xy(optRoute(1,i),2),xy(optRoute(1,1),2)])
    hold on
end
