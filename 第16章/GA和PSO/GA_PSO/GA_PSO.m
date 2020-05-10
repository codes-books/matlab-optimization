%% GA �Ż� PSO
%% ��ջ���
clc;
clear
close all
%% ������ʼ��
lenchrom=7;    %�ַ������ȣ����峤�ȣ���Ⱦɫ����볤��
pc=0.7;        %���ý�����ʣ������н�������Ƕ�ֵ���������ñ仯�Ľ�����ʿ��ñ��ʽ��ʾ�����дһ��������ʺ�����������������ѵ���õ���ֵ��Ϊ�������
pm=0.3;        %���ñ�����ʣ�ͬ��Ҳ������Ϊ�仯��

%����Ⱥ�㷨�е���������
c1 = 1.49445;
c2 = 1.49445;

maxgen=20;   % ��������  
popsize=30; %��Ⱥ��ģ

%���Ӹ����ٶ�
Vmax=1;
Vmin=-1;

%��Ⱥ
popmax=50;
popmin=-50;

% ����ȡֵ��Χ
bound=[popmin popmax;popmin popmax;popmin popmax;popmin popmax;popmin popmax;popmin popmax;popmin popmax];  %������Χ

% �Ż�������Ŀ
par_num=7;

%% ������ʼ���Ӻ��ٶ�
for i=1:popsize
    %�������һ����Ⱥ
    pop(i,:)=popmax*rands(1,par_num);    %��ʼ��Ⱥ
    V(i,:)=rands(1,par_num);  %��ʼ���ٶ�
    %������Ӧ��
    fitness(i)=fun(pop(i,:));   %Ⱦɫ�����Ӧ��
end

%����õ�Ⱦɫ��
[bestfitness bestindex]=min(fitness);
zbest=pop(bestindex,:);   %ȫ�����
gbest=pop;    %�������
fitnessgbest=fitness;   %���������Ӧ��ֵ
fitnesszbest=bestfitness;   %ȫ�������Ӧ��ֵ

%% ����Ѱ��
for i=1:maxgen
    i
    for j=1:popsize
        
        %�ٶȸ��� PSOѡ�����
        V(j,:) = V(j,:) + c1*rand*(gbest(j,:) - pop(j,:)) + c2*rand*(zbest - pop(j,:));
        V(j,find(V(j,:)>Vmax))=Vmax;
        V(j,find(V(j,:)<Vmin))=Vmin;
        
        %��Ⱥ���� PSOѡ�����
        pop(j,:)=pop(j,:)+0.5*V(j,:);
        pop(j,find(pop(j,:)>popmax))=popmax;
        pop(j,find(pop(j,:)<popmin))=popmin;
        
        % ������� GA
        GApop=Cross(pc,lenchrom,pop,popsize,bound);
        
        % ������� GA����
        GApop=Mutation(pm,lenchrom,GApop,popsize,[i maxgen],bound);
        
        pop=GApop; % GA pop --> PSO pop
      
        % ��Ӧ��ֵ --> Լ������
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
grid on
title(['��Ӧ������  ' '��ֹ������' num2str(maxgen)]);
xlabel('��������');ylabel('��Ӧ��');
