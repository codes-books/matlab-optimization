%参数:m_pattern:样品特征库；patternNum:样品数目
%返回值：m_pattern：样本特征库
% funciton 按照粒子群聚类法对全体样品进行分类
% m_pattern为样本的集，每张图片上含有多有个手写数字
%  struct m_pattern(i)
% {
%     feature;%7*7的特征矩阵
%     category;%样品所属类别
% }
%%
clc,clear,close all
global popsize
popsize=20;
global length N;
N=12;               % 每个染色体段数（十进制编码位数）
length=10;          % length为每段基因的二进制编码位数
chromlength=N*length;  %字符串长度（个体长度），染色体的二进制编码长度
pc=0.7;                %设置交叉概率，本例中交叉概率是定值，若想设置变化的交叉概率可用表达式表示，或从写一个交叉概率函数，例如用神经网络训练得到的值作为交叉概率
pm=0.3;               %设置变异概率，同理也可设置为变化的
pop=initpop(popsize,chromlength);                     %运行初始化函数，随机产生初始群体
load template.mat;
patternNum=12;
% x=floor(30*rand(1,patternNum)+1);
% save x.mat x;
load x.mat
n=size(x);
for i=1:n(1,2)
    m_pattern(i).feature=double(template(:,:,x(i))/255);
end

centerNum=3;%类中心数
iterNum=20;%最大迭代次数
particleNum=200;%初始化粒子数目

disType=1;%选用欧式距离法

% global Nwidth;
Nwidth=7;

    %初始化中心和速度
    for i=1:centerNum
        m_center(i).feature=zeros(Nwidth,Nwidth);
        m_center(i).patternNum=0;
        m_center(i).index=i;
        m_velocity(i).feature=zeros(Nwidth,Nwidth);
    end
    
    for i=1:particleNum
        Particle(i).location=m_center;%粒子各中心
        Particle(i).velocity=m_velocity;%粒子各中心速度
        Particle(i).fitness=0;%适应度
        P_id(i).location=m_center;%粒子最优中心；
        P_id(i).velocity=m_velocity;%粒子各中心速度
        P_id(i).fitness=0;%适应度  
    end
    
    P_gd.location=m_center;%全局粒子最优中心
    P_gd.velocity=m_velocity;%全局粒子最有速度
    P_gd.fitness=0;%粒子全局最优适应度
    P_gd.string=zeros(1,patternNum);
    ptDitrib=zeros(particleNum,patternNum);%初始化粒子分布矩阵
    
    for i=1:particleNum%生产随机粒子分布矩阵
        ptDitrib(i,:)=randperm(patternNum);
        for j=1:patternNum
            if(ptDitrib(i,j)>centerNum)
                ptDitrib(i,j)=fix(rand*centerNum+1);
            end
        end
    end
    
    %生成初始粒子群
    for i=1:particleNum
        for j=1:patternNum
            m_pattern(j).category=ptDitrib(i,j);
        end
        for j=1:centerNum
            m_center(j)=CalCenter(m_center(j),m_pattern,patternNum);
        end
        Particle(i).location=m_center;
    end
    
    %初始化参数
    w_max=1;
    w_min=0;
    h1=2;
    h2=2;
    
    for iter=1:iterNum
        iter
        %计算粒子适应度
        for i=1:particleNum
            temp=0.01;%计算群体中每个个体的适应度
            newpop=selection(pop,temp); %选择
            newpop=crossover(newpop,pc,i); %交叉
            newpop=mutation(newpop,pm);  %变异
            for j=1:patternNum %译码！
               temp=decodechrom(newpop,1+(j-1)*length,length);     %将newpop每行(个体）每列（每段基因）转化成十进制数
               temp=temp+GetDistance(m_pattern(j),Particle(i).location(ptDitrib(i,j)),disType);
            end
            if(temp<=0.1) % 如果最大值小于设定阀值，停止进化
                iter=iterNum+1;
                break;
            end
            Particle(i).fitness=1/temp;
        end
        if(iter>iterNum)
            break;
        end
        w=w_max-iter*(w_max-w_min)/iterNum;%更新权重系数
        for i=1:particleNum % 更新 P_id，P_gd
            if(Particle(i).fitness > P_id(i).fitness)
                P_id(i).fitness=Particle(i).fitness;
                P_id(i).location=Particle(i).location;
                P_id(i).velocity=Particle(i).velocity;
                if(Particle(i).fitness > P_gd.fitness)
                    P_gd.fitness=Particle(i).fitness;
                    P_gd.location=Particle(i).location;
                    P_gd.velocity=Particle(i).velocity; 
                    P_gd.string=ptDitrib(i,:);
                end
            end
        end
        %结果存储
        ysw1(iter)=P_id(i).fitness; %个体最优
        ysw2(iter)=P_gd.fitness;    %群体最优
        
        %更新粒子速度、位置
        for i=1:particleNum
            for j=1:centerNum
                Particle(i).velocity(j).feature=w*Particle(i).velocity(j).feature+h1*rand(Nwidth,Nwidth).*...
                (P_id(i).location(j).feature-Particle(i).location(j).feature)+...
                h2*rand(Nwidth,Nwidth).*(P_gd.location(j).feature-Particle(i).location(j).feature);
                Particle(i).location(j).feature=Particle(i).location(j).feature+Particle(i).velocity(j).feature;
            end
        end
        
        %最近邻聚类
        for i=1:particleNum
            for j=1:patternNum
                min=inf;
                for k=1:centerNum
                    tempDis=GetDistance(m_pattern(j),Particle(i).location(k),disType);
                    if(tempDis<min)
                        min=tempDis;
                        m_pattern(j).category=k;
                        ptDitrib(i,j)=k;
                    end
                end
            end
            %重新计算聚类中心
            for j=1:centerNum
                Particle(i).location(j)=CalCenter(Particle(i).location(j),m_pattern,patternNum);
            end
        end
        
        for i=1:patternNum
            m_pattern(i).category=P_gd.string(1,i);
        end
    end
    
    % 结果显示
    disp '聚类中心'
    centerNum    
    disp '聚类中心样本个数'
    m_center.patternNum
    disp '样本隶属中心'
    P_gd.string   
    plot(ysw2,'r--','linewidth',2)
    grid on
    title('群体最优适应度曲线')
    
    
