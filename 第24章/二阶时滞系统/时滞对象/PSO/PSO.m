%基于PSO算法的PID参数优化
clc % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口

%% 参数设置
w = 0.6;      % 惯性因子 
c1 = 2;       % 加速常数
c2 = 2;       % 加速常数

Dim = 3;            % 维数
SwarmSize =100;    % 粒子群规模
MaxIter = 100;      % 最大迭代次数  
MinFit = 0.1;       % 最小适应值 
Vmax = 1;
Vmin = -1;
Ub = [50 50 50];
Lb = [0 0 0];

%% 粒子群初始化
    Range = ones(SwarmSize,1)*(Ub-Lb);
    Swarm = rand(SwarmSize,Dim).*Range + ones(SwarmSize,1)*Lb;    % 初始化粒子群
    VStep = rand(SwarmSize,Dim)*(Vmax-Vmin) + Vmin;                 % 初始化速度
    fSwarm = zeros(SwarmSize,1);
for i=1:SwarmSize
    fSwarm(i,:) = pid_pso(Swarm(i,:));                         % 粒子群的适应值
end

%% 个体极值和群体极值
[bestf bestindex]=min(fSwarm);
zbest=Swarm(bestindex,:);   % 全局最佳
gbest=Swarm;                % 个体最佳
fgbest=fSwarm;              % 个体最佳适应值
fzbest=bestf;               % 全局最佳适应值

%% 迭代寻优
iter = 0;
y_fitness = zeros(1,MaxIter);   % 预先产生4个空矩阵
K_p = zeros(1,MaxIter);         
K_i = zeros(1,MaxIter);
K_d = zeros(1,MaxIter);
while( (iter < MaxIter) && (fzbest > MinFit) )
    for j=1:SwarmSize
        % 速度更新
        VStep(j,:) = w*VStep(j,:) + c1*rand*(gbest(j,:) - Swarm(j,:)) + c2*rand*(zbest - Swarm(j,:));
        if VStep(j,:)>Vmax, VStep(j,:)=Vmax; end
        if VStep(j,:)<Vmin, VStep(j,:)=Vmin; end
        % 位置更新
        Swarm(j,:)=Swarm(j,:)+VStep(j,:);
        for k=1:Dim
            if Swarm(j,k)>Ub(k), Swarm(j,k)=Ub(k); end
            if Swarm(j,k)<Lb(k), Swarm(j,k)=Lb(k); end
        end
        % 适应值
        fSwarm(j,:) =pid_pso(Swarm(j,:));
        % 个体最优更新     
        if fSwarm(j) < fgbest(j)
            gbest(j,:) = Swarm(j,:);
            fgbest(j) = fSwarm(j);
        end
        % 群体最优更新
        if fSwarm(j) < fzbest
            zbest = Swarm(j,:);
            fzbest = fSwarm(j);
        end
    end 
    iter = iter+1;                      % 迭代次数更新
    y_fitness(1,iter) = fzbest;         % 为绘图做准备
    K_p(1,iter) = zbest(1);
    K_i(1,iter) = zbest(2);
    K_d(1,iter) = zbest(3);
end
%%绘图
figure(1)      % 绘制性能指标ITAE的变化曲线
plot(y_fitness,'LineWidth',3)
title('最优个体适应值','fontsize',10);
xlabel('迭代次数','fontsize',10);ylabel('适应值','fontsize',10);
set(gca,'Fontsize',10);
grid on

figure(2)      % 绘制PID控制器参数变化曲线
plot(K_p,'LineWidth',3)
hold on
plot(K_i,'k','LineWidth',3)
plot(K_d,'--r','LineWidth',3)
title('Kp、Ki、Kd 优化曲线','fontsize',10);
xlabel('迭代次数','fontsize',10);ylabel('参数值','fontsize',10);
set(gca,'Fontsize',10);
legend('Kp','Ki','Kd',1);
grid on