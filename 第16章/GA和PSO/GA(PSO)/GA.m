%% GA
clc % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口
warning off
%% 参数初始化
popsize=100;              %种群规模
lenchrom=7;              %变量字串长度

pc=0.7;                  %设置交叉概率，本例中交叉概率是定值，若想设置变化的交叉概率可用表达式表示，或从写一个交叉概率函数，例如用神经网络训练得到的值作为交叉概率
pm=0.3;                  %设置变异概率，同理也可设置为变化的

maxgen=100;   % 进化次数  

%种群
popmax=50;
popmin=0;
bound=[popmin popmax;popmin popmax;popmin popmax;popmin popmax;popmin popmax;popmin popmax;popmin popmax];  %变量范围

%% 产生初始粒子和速度
for i=1:popsize
    %随机产生一个种群
    GApop(i,:)=Code(lenchrom,bound);       %随机产生个体
    %计算适应度
    fitness(i)=fun(GApop(i,:));            %染色体的适应度
end

%找最好的染色体
[bestfitness bestindex]=min(fitness);
zbest=GApop(bestindex,:);   %全局最佳
gbest=GApop;                %个体最佳
fitnessgbest=fitness;       %个体最佳适应度值
fitnesszbest=bestfitness;   %全局最佳适应度值

%% 迭代寻优
for i=1:maxgen
        i
        %种群更新 GA选择更新
        GApop=Select2(GApop,fitness,popsize);

        % 交叉操作 GA
        GApop=Cross(pc,lenchrom,GApop,popsize,bound);

        % 变异操作 GA变异
        GApop=Mutation(pm,lenchrom,GApop,popsize,[i maxgen],bound);

        pop=GApop;
        
      for j=1:popsize
        %适应度值
        if 0.072*pop(j,1)+0.063*pop(j,2)+0.057*pop(j,3)+0.05*pop(j,4)+0.032*pop(j,5)+0.0442*pop(j,6)+0.0675*pop(j,7)<=264.4
            if 128*pop(j,1)+78.1*pop(j,2)+64.1*pop(j,3)+43*pop(j,4)+58.1*pop(j,5)+36.9*pop(j,6)+50.5*pop(j,7)<=69719
                    fitness(j)=fun(pop(j,:));
            end
        end
        %个体最优更新
        if fitness(j) < fitnessgbest(j)
            gbest(j,:) = pop(j,:);
            fitnessgbest(j) = fitness(j);
        end
        
        %群体最优更新
        if fitness(j) < fitnesszbest
            zbest = pop(j,:);
            fitnesszbest = fitness(j);
        end
        
    end
    
    yy(i)=fitnesszbest;     
end

%% 结果
disp '*************best particle number****************'
zbest

%%
plot(yy,'linewidth',2);
title(['适应度曲线  ' '终止代数＝' num2str(maxgen)]);
xlabel('进化代数');ylabel('适应度');
grid on
