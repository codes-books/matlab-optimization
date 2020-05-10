%����:m_pattern:��Ʒ�����⣻patternNum:��Ʒ��Ŀ
%����ֵ��m_pattern������������
% funciton ��������Ⱥ���෨��ȫ����Ʒ���з���
% m_patternΪ�����ļ���ÿ��ͼƬ�Ϻ��ж��и���д����
%  struct m_pattern(i)
% {
%     feature;%7*7����������
%     category;%��Ʒ�������
% }
%%
clc,clear,close all
global popsize
popsize=20;
global length N;
N=12;               % ÿ��Ⱦɫ�������ʮ���Ʊ���λ����
length=10;          % lengthΪÿ�λ���Ķ����Ʊ���λ��
chromlength=N*length;  %�ַ������ȣ����峤�ȣ���Ⱦɫ��Ķ����Ʊ��볤��
pc=0.7;                %���ý�����ʣ������н�������Ƕ�ֵ���������ñ仯�Ľ�����ʿ��ñ��ʽ��ʾ�����дһ��������ʺ�����������������ѵ���õ���ֵ��Ϊ�������
pm=0.3;               %���ñ�����ʣ�ͬ��Ҳ������Ϊ�仯��
pop=initpop(popsize,chromlength);                     %���г�ʼ�����������������ʼȺ��
load template.mat;
patternNum=12;
% x=floor(30*rand(1,patternNum)+1);
% save x.mat x;
load x.mat
n=size(x);
for i=1:n(1,2)
    m_pattern(i).feature=double(template(:,:,x(i))/255);
end

centerNum=3;%��������
iterNum=20;%����������
particleNum=200;%��ʼ��������Ŀ

disType=1;%ѡ��ŷʽ���뷨

% global Nwidth;
Nwidth=7;

    %��ʼ�����ĺ��ٶ�
    for i=1:centerNum
        m_center(i).feature=zeros(Nwidth,Nwidth);
        m_center(i).patternNum=0;
        m_center(i).index=i;
        m_velocity(i).feature=zeros(Nwidth,Nwidth);
    end
    
    for i=1:particleNum
        Particle(i).location=m_center;%���Ӹ�����
        Particle(i).velocity=m_velocity;%���Ӹ������ٶ�
        Particle(i).fitness=0;%��Ӧ��
        P_id(i).location=m_center;%�����������ģ�
        P_id(i).velocity=m_velocity;%���Ӹ������ٶ�
        P_id(i).fitness=0;%��Ӧ��  
    end
    
    P_gd.location=m_center;%ȫ��������������
    P_gd.velocity=m_velocity;%ȫ�����������ٶ�
    P_gd.fitness=0;%����ȫ��������Ӧ��
    P_gd.string=zeros(1,patternNum);
    ptDitrib=zeros(particleNum,patternNum);%��ʼ�����ӷֲ�����
    
    for i=1:particleNum%����������ӷֲ�����
        ptDitrib(i,:)=randperm(patternNum);
        for j=1:patternNum
            if(ptDitrib(i,j)>centerNum)
                ptDitrib(i,j)=fix(rand*centerNum+1);
            end
        end
    end
    
    %���ɳ�ʼ����Ⱥ
    for i=1:particleNum
        for j=1:patternNum
            m_pattern(j).category=ptDitrib(i,j);
        end
        for j=1:centerNum
            m_center(j)=CalCenter(m_center(j),m_pattern,patternNum);
        end
        Particle(i).location=m_center;
    end
    
    %��ʼ������
    w_max=1;
    w_min=0;
    h1=2;
    h2=2;
    
    for iter=1:iterNum
        iter
        %����������Ӧ��
        for i=1:particleNum
            temp=0.01;%����Ⱥ����ÿ���������Ӧ��
            newpop=selection(pop,temp); %ѡ��
            newpop=crossover(newpop,pc,i); %����
            newpop=mutation(newpop,pm);  %����
            for j=1:patternNum %���룡
               temp=decodechrom(newpop,1+(j-1)*length,length);     %��newpopÿ��(���壩ÿ�У�ÿ�λ���ת����ʮ������
               temp=temp+GetDistance(m_pattern(j),Particle(i).location(ptDitrib(i,j)),disType);
            end
            if(temp<=0.1) % ������ֵС���趨��ֵ��ֹͣ����
                iter=iterNum+1;
                break;
            end
            Particle(i).fitness=1/temp;
        end
        if(iter>iterNum)
            break;
        end
        w=w_max-iter*(w_max-w_min)/iterNum;%����Ȩ��ϵ��
        for i=1:particleNum % ���� P_id��P_gd
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
        %����洢
        ysw1(iter)=P_id(i).fitness; %��������
        ysw2(iter)=P_gd.fitness;    %Ⱥ������
        
        %���������ٶȡ�λ��
        for i=1:particleNum
            for j=1:centerNum
                Particle(i).velocity(j).feature=w*Particle(i).velocity(j).feature+h1*rand(Nwidth,Nwidth).*...
                (P_id(i).location(j).feature-Particle(i).location(j).feature)+...
                h2*rand(Nwidth,Nwidth).*(P_gd.location(j).feature-Particle(i).location(j).feature);
                Particle(i).location(j).feature=Particle(i).location(j).feature+Particle(i).velocity(j).feature;
            end
        end
        
        %����ھ���
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
            %���¼����������
            for j=1:centerNum
                Particle(i).location(j)=CalCenter(Particle(i).location(j),m_pattern,patternNum);
            end
        end
        
        for i=1:patternNum
            m_pattern(i).category=P_gd.string(1,i);
        end
    end
    
    % �����ʾ
    disp '��������'
    centerNum    
    disp '����������������'
    m_center.patternNum
    disp '������������'
    P_gd.string   
    plot(ysw2,'r--','linewidth',2)
    grid on
    title('Ⱥ��������Ӧ������')
    
    
