%����SOA�㷨��PID�����Ż�
clc % ����
clear all; % ɾ��workplace����
close all; % �ص���ʾͼ�δ���

%%��������
Umax=0.9500;%���������ֵ
Umin=0.0111;%��С������ֵ
Wmax=0.9;%Ȩ�����ֵ
Wmin=0.1;%Ȩ����Сֵ
Dim = 3;            % ά��
SwarmSize =30;    % ����Ⱥ��ģ
MaxIter = 100;      % ����������
MinFit = 10;       % ��С��Ӧֵ
Ub = [100 100 100];
Lb = [0 0 0];
%%��Ⱥ��ʼ��
Range = ones(SwarmSize,1)*(Ub-Lb);
Swarm = rand(SwarmSize,Dim).*Range + ones(SwarmSize,1)*Lb;    % ��ʼ������Ⱥ
fSwarm = zeros(SwarmSize,1);
for i=1:SwarmSize
    fSwarm(i,:) = PID_SOA(Swarm(i,:));                       % ����Ⱥ����Ӧֵ
end
%%���弫ֵ��Ⱥ�弫ֵ
[bestf bestindex]=min(fSwarm);
zbest=Swarm(bestindex,:);   % ȫ�����
gbest=Swarm;                % �������
fgbest=fSwarm;              % ���������Ӧֵ
fzbest=bestf;               % ȫ�������Ӧֵ
%����Ѱ��
Di=0*rand(SwarmSize,Dim);
Buchang=0*rand(SwarmSize,Dim);
C=0*rand(SwarmSize,Dim);
Diego=0*rand(SwarmSize,Dim);
Dialt=0*rand(SwarmSize,Dim);
Dipro=0*rand(SwarmSize,Dim);
iter = 0;
y_fitness = zeros(1,MaxIter);   % Ԥ�Ȳ���4���վ���
K_p = zeros(1,MaxIter);         
K_i = zeros(1,MaxIter);
K_d = zeros(1,MaxIter);
while( (iter < MaxIter) && (fzbest > MinFit) )
    for i=1:SwarmSize
        W=Wmax-iter*(Wmax-Wmin)/MaxIter;
        Diego(i,:)=sign(gbest(i,:) -Swarm(i,:));%ȷ����������
        Dialt(i,:)=sign(zbest -Swarm(i,:));%ȷ����������
        if PID_SOA(gbest(i,:))>=PID_SOA(Swarm(i,:))%ȷ��Ԥ������
            Dipro(i,:)=-Di(i,:);
        else
            Dipro(i,:)=Di(i,:);
        end
        Di(i,:)=sign(W* Dipro(i,:)+0.5*Diego(i,:)+0.5*Dialt(i,:));%ȷ�������ݶȷ���
        [Orderfgbest,Indexfgbest]=sort(fgbest,'descend');
        u=Umax-(SwarmSize-Indexfgbest(i))*(Umax-Umin)/(SwarmSize-1);
        U=u+(1-u)*rand;
        H=(MaxIter-iter)/MaxIter;%����������Ȩ�صı仯
        C(i,:)=H*abs(zbest-10*rand(1,3));%ȷ����˹�����Ĳ���
        T=sqrt(-log(U));
        Buchang(i,:)=C(i,:)*T;%ȷ�����������Ĵ�
        Buchang(i,find(Buchang(i,:)>3*max(C(i,:))))=3*max(C(i,:));
        %����λ��
        Swarm(i,:)=Swarm(i,:)+Di(i,:).*Buchang(i,:);
        Swarm(i,find(Swarm(i,:)>100))=100;
        Swarm(i,find(Swarm(i,:)<0))=0;
        % ��Ӧֵ
        fSwarm(i,:) =PID_SOA(Swarm(i,:));
        % �������Ÿ���     
        if fSwarm(i) < fgbest(i)
            gbest(i,:) = Swarm(i,:);
            fgbest(i) = fSwarm(i);
        end
        % Ⱥ�����Ÿ���
        if fSwarm(i) < fzbest
            zbest = Swarm(i,:);
            fzbest = fSwarm(i);
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
plot(y_fitness,'LineWidth',4)
title('���Ÿ�����Ӧֵ','fontsize',10);
xlabel('��������','fontsize',10);ylabel('��Ӧֵ','fontsize',10);
set(gca,'Fontsize',10);
grid on

figure(2)      % ����PID�����������仯����
plot(K_p,'LineWidth',4)
hold on
plot(K_i,'k','LineWidth',4)
plot(K_d,'--r','LineWidth',4)
title('Kp��Ki��Kd �Ż�����','fontsize',10);
xlabel('��������','fontsize',10);ylabel('����ֵ','fontsize',10);
set(gca,'Fontsize',10);
legend('Kp','Ki','Kd',1);
grid on
        
        