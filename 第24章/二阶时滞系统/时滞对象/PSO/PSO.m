%����PSO�㷨��PID�����Ż�
clc % ����
clear all; % ɾ��workplace����
close all; % �ص���ʾͼ�δ���

%% ��������
w = 0.6;      % �������� 
c1 = 2;       % ���ٳ���
c2 = 2;       % ���ٳ���

Dim = 3;            % ά��
SwarmSize =100;    % ����Ⱥ��ģ
MaxIter = 100;      % ����������  
MinFit = 0.1;       % ��С��Ӧֵ 
Vmax = 1;
Vmin = -1;
Ub = [50 50 50];
Lb = [0 0 0];

%% ����Ⱥ��ʼ��
    Range = ones(SwarmSize,1)*(Ub-Lb);
    Swarm = rand(SwarmSize,Dim).*Range + ones(SwarmSize,1)*Lb;    % ��ʼ������Ⱥ
    VStep = rand(SwarmSize,Dim)*(Vmax-Vmin) + Vmin;                 % ��ʼ���ٶ�
    fSwarm = zeros(SwarmSize,1);
for i=1:SwarmSize
    fSwarm(i,:) = pid_pso(Swarm(i,:));                         % ����Ⱥ����Ӧֵ
end

%% ���弫ֵ��Ⱥ�弫ֵ
[bestf bestindex]=min(fSwarm);
zbest=Swarm(bestindex,:);   % ȫ�����
gbest=Swarm;                % �������
fgbest=fSwarm;              % ���������Ӧֵ
fzbest=bestf;               % ȫ�������Ӧֵ

%% ����Ѱ��
iter = 0;
y_fitness = zeros(1,MaxIter);   % Ԥ�Ȳ���4���վ���
K_p = zeros(1,MaxIter);         
K_i = zeros(1,MaxIter);
K_d = zeros(1,MaxIter);
while( (iter < MaxIter) && (fzbest > MinFit) )
    for j=1:SwarmSize
        % �ٶȸ���
        VStep(j,:) = w*VStep(j,:) + c1*rand*(gbest(j,:) - Swarm(j,:)) + c2*rand*(zbest - Swarm(j,:));
        if VStep(j,:)>Vmax, VStep(j,:)=Vmax; end
        if VStep(j,:)<Vmin, VStep(j,:)=Vmin; end
        % λ�ø���
        Swarm(j,:)=Swarm(j,:)+VStep(j,:);
        for k=1:Dim
            if Swarm(j,k)>Ub(k), Swarm(j,k)=Ub(k); end
            if Swarm(j,k)<Lb(k), Swarm(j,k)=Lb(k); end
        end
        % ��Ӧֵ
        fSwarm(j,:) =pid_pso(Swarm(j,:));
        % �������Ÿ���     
        if fSwarm(j) < fgbest(j)
            gbest(j,:) = Swarm(j,:);
            fgbest(j) = fSwarm(j);
        end
        % Ⱥ�����Ÿ���
        if fSwarm(j) < fzbest
            zbest = Swarm(j,:);
            fzbest = fSwarm(j);
        end
    end 
    iter = iter+1;                      % ������������
    y_fitness(1,iter) = fzbest;         % Ϊ��ͼ��׼��
    K_p(1,iter) = zbest(1);
    K_i(1,iter) = zbest(2);
    K_d(1,iter) = zbest(3);
end
%%��ͼ
figure(1)      % ��������ָ��ITAE�ı仯����
plot(y_fitness,'LineWidth',3)
title('���Ÿ�����Ӧֵ','fontsize',10);
xlabel('��������','fontsize',10);ylabel('��Ӧֵ','fontsize',10);
set(gca,'Fontsize',10);
grid on

figure(2)      % ����PID�����������仯����
plot(K_p,'LineWidth',3)
hold on
plot(K_i,'k','LineWidth',3)
plot(K_d,'--r','LineWidth',3)
title('Kp��Ki��Kd �Ż�����','fontsize',10);
xlabel('��������','fontsize',10);ylabel('����ֵ','fontsize',10);
set(gca,'Fontsize',10);
legend('Kp','Ki','Kd',1);
grid on