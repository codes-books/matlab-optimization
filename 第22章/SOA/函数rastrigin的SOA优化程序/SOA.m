% Seeker Optimition Algorithm for f(x1,x2) optimum
clear all;
close all;
format long
% Parameters
sizepop=100;%种群规模
maxgen=100;%最大迭代次数
m=2;%空间维数
Umax=0.9500;%最大隶属度值
Umin=0.0111;%最小隶属度值
Wmax=0.9;%权重最大值
Wmin=0.1;%权重最小值
popmax=5;
popmin=-5;
% 初始化种群个体
for i=1:sizepop
    pop(i,:)=5*rands(1,2);
    fitness(i)=rastrigin(pop(i,:));% 计算适应度
end
%寻找具有最好适应度的个体
[bestfitness bestindex]=min(fitness);
zbest=pop(bestindex,:);   %全局最佳
gbest=pop;    %个体最佳
fitnessgbest=fitness;   %个体最佳适应度值
fitnesszbest=bestfitness;   %全局最佳适应度值
%%迭代寻优
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
        Diego(i,:)=sign(gbest(i,:) - pop(i,:));%确定利己方向
        Dialt(i,:)=sign(zbest - pop(i,:));%确定利他方向
        if rastrigin(gbest(i,:))>=rastrigin(pop(i,:))%确定预动方向
            Dipro(i,:)=-Di(i,:);
        else
            Dipro(i,:)=Di(i,:);
        end
        Di(i,:)=sign(W* Dipro(i,:)+rand*Diego(i,:)+rand*Dialt(i,:));%确定经验梯度方向
        [Orderfitnessgbest,Indexfitnessgbest]=sort(fitnessgbest,'descend');
        u=Umax-(sizepop-Indexfitnessgbest(i))*(Umax-Umin)/(sizepop-1);
        U=u+(1-u)*rand;
        H(t)=(maxgen-t)/maxgen;%迭代过程中权重的变化
        C(i,:)=H(t)*abs(zbest-5*rands(1,2));%确定高斯函数的参数
        T=sqrt(-log(U));
        Buchang(i,:)=C(i,:)*T;%确定搜索不长的大小
        Buchang(i,find(Buchang(i,:)>3*max(C(i,:))))=3*max(C(i,:));
        Buchang(i,find(Buchang(i,:)<0))=0;
        %更新位置
        pop(i,:)=pop(i,:)+Di(i,:).*Buchang(i,:);
        pop(i,find(pop(i,:)>popmax))=popmax;
        pop(i,find(pop(i,:)<popmin))=popmin;
        fitness(i)=rastrigin(pop(i,:));%计算适应度值
        %个体最优更新
        if fitness(i) < fitnessgbest(i)
            gbest(i,:) = pop(i,:);
            fitnessgbest(i) = fitness(i);
        end
         %群体最优更新
        if fitness(i) < fitnesszbest
            zbest = pop(i,:);
            fitnesszbest = fitness(i);
        end
    end
    yy(t)=fitnesszbest;     
end
%% 结果分析
plot(yy,'b','LineWidth',4)
title(['适应度曲线  ' '终止代数＝' num2str(maxgen)]);
xlabel('进化代数');ylabel('适应度');