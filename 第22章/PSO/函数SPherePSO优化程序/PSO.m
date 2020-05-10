% ����Ⱥ�����Ż�
clc % ����
clear all; % ɾ��workplace����
close all; % �ص���ʾͼ�δ���

%% ������ʼ��
%����Ⱥ�㷨�е���������
c1 = 1.49445;
c2 = 1.49445;

maxgen=100;   % ��������  
sizepop=20;   %��Ⱥ��ģ

Vmax=1;%�ٶ�����
Vmin=-1;
popmax=15;%��Ⱥ����
popmin=-15;

%% ������ʼ���Ӻ��ٶ�
for i=1:sizepop                 %�������һ����Ⱥ
    pop(i,:)=15*rands(1,10);    %��ʼ��Ⱥ
    V(i,:)=rands(1,10);  %��ʼ���ٶ�
    %������Ӧ��
    fitness(i)=Sphere(pop(i,:));   %Ⱦɫ�����Ӧ��
end

%����õ�Ⱦɫ��
[bestfitness bestindex]=min(fitness);
zbest=pop(bestindex,:);   %ȫ�����
gbest=pop;    %�������
fitnessgbest=fitness;   %���������Ӧ��ֵ
fitnesszbest=bestfitness;   %ȫ�������Ӧ��ֵ

%% ����Ѱ��
for i=1:maxgen
    
    for j=1:sizepop
        
        %�ٶȸ���
        V(j,:) = V(j,:) + c1*rand*(gbest(j,:) - pop(j,:)) + c2*rand*(zbest - pop(j,:));
        V(j,find(V(j,:)>Vmax))=Vmax;
        V(j,find(V(j,:)<Vmin))=Vmin;
        
        %��Ⱥ����
        pop(j,:)=pop(j,:)+0.5*V(j,:);
        pop(j,find(pop(j,:)>popmax))=popmax;
        pop(j,find(pop(j,:)<popmin))=popmin;
        
        %����Ӧ���죨��������Ⱥ�㷨����ֲ����ţ�
        if rand>0.8
            k=ceil(2*rand);%ceil�����������ȡ��
            pop(j,k)=rand;
        end
      
        %��Ӧ��ֵ
        fitness(j)=Sphere(pop(j,:));
        
        
        %�������Ÿ���
        if fitness(j) < fitnessgbest(j)
            gbest(j,:) = pop(j,:);
            fitnessgbest(j) = fitness(j);
        end
        
        %Ⱥ�����Ÿ���
        if fitness(j) < fitnesszbest
            zbest = pop(j,:);
            fitnesszbest = fitness(j);
        end
        
    end
    yy(i)=fitnesszbest;    
        
end

%% �������
plot(yy,'b','LineWidth',4)
title(['��Ӧ������  ' '��ֹ������' num2str(maxgen)]);
xlabel('��������');ylabel('��Ӧ��');