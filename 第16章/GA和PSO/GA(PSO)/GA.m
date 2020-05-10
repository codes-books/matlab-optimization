%% GA
clc % ����
clear all; % ɾ��workplace����
close all; % �ص���ʾͼ�δ���
warning off
%% ������ʼ��
popsize=100;              %��Ⱥ��ģ
lenchrom=7;              %�����ִ�����

pc=0.7;                  %���ý�����ʣ������н�������Ƕ�ֵ���������ñ仯�Ľ�����ʿ��ñ��ʽ��ʾ�����дһ��������ʺ�����������������ѵ���õ���ֵ��Ϊ�������
pm=0.3;                  %���ñ�����ʣ�ͬ��Ҳ������Ϊ�仯��

maxgen=100;   % ��������  

%��Ⱥ
popmax=50;
popmin=0;
bound=[popmin popmax;popmin popmax;popmin popmax;popmin popmax;popmin popmax;popmin popmax;popmin popmax];  %������Χ

%% ������ʼ���Ӻ��ٶ�
for i=1:popsize
    %�������һ����Ⱥ
    GApop(i,:)=Code(lenchrom,bound);       %�����������
    %������Ӧ��
    fitness(i)=fun(GApop(i,:));            %Ⱦɫ�����Ӧ��
end

%����õ�Ⱦɫ��
[bestfitness bestindex]=min(fitness);
zbest=GApop(bestindex,:);   %ȫ�����
gbest=GApop;                %�������
fitnessgbest=fitness;       %���������Ӧ��ֵ
fitnesszbest=bestfitness;   %ȫ�������Ӧ��ֵ

%% ����Ѱ��
for i=1:maxgen
        i
        %��Ⱥ���� GAѡ�����
        GApop=Select2(GApop,fitness,popsize);

        % ������� GA
        GApop=Cross(pc,lenchrom,GApop,popsize,bound);

        % ������� GA����
        GApop=Mutation(pm,lenchrom,GApop,popsize,[i maxgen],bound);

        pop=GApop;
        
      for j=1:popsize
        %��Ӧ��ֵ
        if 0.072*pop(j,1)+0.063*pop(j,2)+0.057*pop(j,3)+0.05*pop(j,4)+0.032*pop(j,5)+0.0442*pop(j,6)+0.0675*pop(j,7)<=264.4
            if 128*pop(j,1)+78.1*pop(j,2)+64.1*pop(j,3)+43*pop(j,4)+58.1*pop(j,5)+36.9*pop(j,6)+50.5*pop(j,7)<=69719
                    fitness(j)=fun(pop(j,:));
            end
        end
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

%% ���
disp '*************best particle number****************'
zbest

%%
plot(yy,'linewidth',2);
title(['��Ӧ������  ' '��ֹ������' num2str(maxgen)]);
xlabel('��������');ylabel('��Ӧ��');
grid on
