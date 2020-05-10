%基于SOA算法的PID参数优化
clc % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口

%%参数设置
Umax=0.9500;%最大隶属度值
Umin=0.0111;%最小隶属度值
Wmax=0.9;%权重最大值
Wmin=0.1;%权重最小值
Dim = 3;            % 维数
SwarmSize =30;    % 粒子群规模
MaxIter = 100;      % 最大迭代次数
MinFit = 10;       % 最小适应值
Ub = [100 100 100];
Lb = [0 0 0];
%%种群初始化
Range = ones(SwarmSize,1)*(Ub-Lb);
Swarm = rand(SwarmSize,Dim).*Range + ones(SwarmSize,1)*Lb;    % 初始化粒子群
fSwarm = zeros(SwarmSize,1);
for i=1:SwarmSize
    fSwarm(i,:) = PID_SOA(Swarm(i,:));                       % 粒子群的适应值
end
%%个体极值和群体极值
[bestf bestindex]=min(fSwarm);
zbest=Swarm(bestindex,:);   % 全局最佳
gbest=Swarm;                % 个体最佳
fgbest=fSwarm;              % 个体最佳适应值
fzbest=bestf;               % 全局最佳适应值
%迭代寻优
Di=0*rand(SwarmSize,Dim);
Buchang=0*rand(SwarmSize,Dim);
C=0*rand(SwarmSize,Dim);
Diego=0*rand(SwarmSize,Dim);
Dialt=0*rand(SwarmSize,Dim);
Dipro=0*rand(SwarmSize,Dim);
iter = 0;
y_fitness = zeros(1,MaxIter);   % 预先产生4个空矩阵
K_p = zeros(1,MaxIter);         
K_i = zeros(1,MaxIter);
K_d = zeros(1,MaxIter);
while( (iter < MaxIter) && (fzbest > MinFit) )
    for i=1:SwarmSize
        W=Wmax-iter*(Wmax-Wmin)/MaxIter;
        Diego(i,:)=sign(gbest(i,:) -Swarm(i,:));%确定利己方向
        Dialt(i,:)=sign(zbest -Swarm(i,:));%确定利他方向
        if PID_SOA(gbest(i,:))>=PID_SOA(Swarm(i,:))%确定预动方向
            Dipro(i,:)=-Di(i,:);
        else
            Dipro(i,:)=Di(i,:);
        end
        Di(i,:)=sign(W* Dipro(i,:)+0.5*Diego(i,:)+0.5*Dialt(i,:));%确定经验梯度方向
        [Orderfgbest,Indexfgbest]=sort(fgbest,'descend');
        u=Umax-(SwarmSize-Indexfgbest(i))*(Umax-Umin)/(SwarmSize-1);
        U=u+(1-u)*rand;
        H=(MaxIter-iter)/MaxIter;%迭代过程中权重的变化
        C(i,:)=H*abs(zbest-10*rand(1,3));%确定高斯函数的参数
        T=sqrt(-log(U));
        Buchang(i,:)=C(i,:)*T;%确定搜索不长的大
        Buchang(i,find(Buchang(i,:)>3*max(C(i,:))))=3*max(C(i,:));
        %更新位置
        Swarm(i,:)=Swarm(i,:)+Di(i,:).*Buchang(i,:);
        Swarm(i,find(Swarm(i,:)>100))=100;
        Swarm(i,find(Swarm(i,:)<0))=0;
        % 适应值
        fSwarm(i,:) =PID_SOA(Swarm(i,:));
        % 个体最优更新     
        if fSwarm(i) < fgbest(i)
            gbest(i,:) = Swarm(i,:);
            fgbest(i) = fSwarm(i);
        end
        % 群体最优更新
        if fSwarm(i) < fzbest
            zbest = Swarm(i,:);
            fzbest = fSwarm(i);
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
plot(y_fitness,'LineWidth',4)
title('最优个体适应值','fontsize',10);
xlabel('迭代次数','fontsize',10);ylabel('适应值','fontsize',10);
set(gca,'Fontsize',10);
grid on

figure(2)      % 绘制PID控制器参数变化曲线
plot(K_p,'LineWidth',4)
hold on
plot(K_i,'k','LineWidth',4)
plot(K_d,'--r','LineWidth',4)
title('Kp、Ki、Kd 优化曲线','fontsize',10);
xlabel('迭代次数','fontsize',10);ylabel('参数值','fontsize',10);
set(gca,'Fontsize',10);
legend('Kp','Ki','Kd',1);
grid on
        
        