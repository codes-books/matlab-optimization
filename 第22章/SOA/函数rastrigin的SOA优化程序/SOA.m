% Seeker Optimition Algorithm for f(x1,x2) optimum
clear all;
close all;
format long
% Parameters
sizepop=100;%��Ⱥ��ģ
maxgen=100;%����������
m=2;%�ռ�ά��
Umax=0.9500;%���������ֵ
Umin=0.0111;%��С������ֵ
Wmax=0.9;%Ȩ�����ֵ
Wmin=0.1;%Ȩ����Сֵ
popmax=5;
popmin=-5;
% ��ʼ����Ⱥ����
for i=1:sizepop
    pop(i,:)=5*rands(1,2);
    fitness(i)=rastrigin(pop(i,:));% ������Ӧ��
end
%Ѱ�Ҿ��������Ӧ�ȵĸ���
[bestfitness bestindex]=min(fitness);
zbest=pop(bestindex,:);   %ȫ�����
gbest=pop;    %�������
fitnessgbest=fitness;   %���������Ӧ��ֵ
fitnesszbest=bestfitness;   %ȫ�������Ӧ��ֵ
%%����Ѱ��
Di=0*rand(sizepop,m);
Di(1,:)=1;
Buchang=0*rand(sizepop,m);
C=0*rand(sizepop,m);
Diego=0*rand(sizepop,m);
Dialt=0*rand(sizepop,m);
Dipro=0*rand(sizepop,m);
yy(1)=fitnesszbest;
for t=2:maxgen
    for i=1:sizepop
        W=Wmax-t*(Wmax-Wmin)/maxgen;
        Diego(i,:)=sign(gbest(i,:) - pop(i,:));%ȷ����������
        Dialt(i,:)=sign(zbest - pop(i,:));%ȷ����������
        if rastrigin(gbest(i,:))>=rastrigin(pop(i,:))%ȷ��Ԥ������
            Dipro(i,:)=-Di(i,:);
        else
            Dipro(i,:)=Di(i,:);
        end
        Di(i,:)=sign(W* Dipro(i,:)+rand*Diego(i,:)+rand*Dialt(i,:));%ȷ�������ݶȷ���
        [Orderfitnessgbest,Indexfitnessgbest]=sort(fitnessgbest,'descend');
        u=Umax-(sizepop-Indexfitnessgbest(i))*(Umax-Umin)/(sizepop-1);
        U=u+(1-u)*rand;
        H(t)=(maxgen-t)/maxgen;%����������Ȩ�صı仯
        C(i,:)=H(t)*abs(zbest-5*rands(1,2));%ȷ����˹�����Ĳ���
        T=sqrt(-log(U));
        Buchang(i,:)=C(i,:)*T;%ȷ�����������Ĵ�С
        Buchang(i,find(Buchang(i,:)>3*max(C(i,:))))=3*max(C(i,:));
        Buchang(i,find(Buchang(i,:)<0))=0;
        %����λ��
        pop(i,:)=pop(i,:)+Di(i,:).*Buchang(i,:);
        pop(i,find(pop(i,:)>popmax))=popmax;
        pop(i,find(pop(i,:)<popmin))=popmin;
        fitness(i)=rastrigin(pop(i,:));%������Ӧ��ֵ
        %�������Ÿ���
        if fitness(i) < fitnessgbest(i)
            gbest(i,:) = pop(i,:);
            fitnessgbest(i) = fitness(i);
        end
         %Ⱥ�����Ÿ���
        if fitness(i) < fitnesszbest
            zbest = pop(i,:);
            fitnesszbest = fitness(i);
        end
    end
    yy(t)=fitnesszbest;     
end
%% �������
plot(yy,'b','LineWidth',4)
title(['��Ӧ������  ' '��ֹ������' num2str(maxgen)]);
xlabel('��������');ylabel('��Ӧ��');