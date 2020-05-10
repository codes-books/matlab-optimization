%粒子群聚类算法
function [m_pattern]=C_PSO(m_pattern,patternNum)
%         disType=DisSelDlg();%获得距离计算型
        % [centerNum iterNum]=InputClassDlg;%获得类中心数和最大迭代次数
%         patternNum=12;
disType=1;
centerNum=6;%类中心数
iterNum=20;%最大迭代次数
        particleNum=200;%初始化粒子数
         %初始化中心和速度
         global Nwidth;
         for i=1:centerNum
             m_center(i).feature=zeros(Nwidth,Nwidth);
             m_center(i).patternNum=0;
             m_center(i).index=i;
             m_velocity(i).feature=zeros(Nwidth, Nwidth);
             for i=1:particleNum
                 Particle(i).location=m_center;%粒子各中心
                 Particle(i).velocity=m_velocity;%粒子各中心速度
                 Particle(i).fitness=0;%适应度
                 P_id(i).velocity=m_velocity;%粒子最优速度
                 P_id(i).location=m_center;%粒子最优中心
                 P_id(i).fitness=0;%粒子最优适应度
             end
             P_gd.location=m_center;%全局粒子最优中心
             P_gd.velocity=m_velocity;%全局粒子最优速度
             P_gd.fitness=0;%粒子全局最优适应度
             P_gd.string=zeros(1,patternNum);
             ptDitrib=zeros(particleNum,patternNum);%初始化粒子分布矩阵
             for i=1:particleNum %生产随机粒子分布矩阵
                 ptDitrib(i,:)=randperm(patternNum);
                 for j=1:patternNum
                     if (ptDitrib(i,j)>centerNum)
                         ptDitrib(i,j)=fix(rand*centerNum+1);
                     end
                 end
             end
             %生产初始粒子群
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
                 %计算粒子适应度
                 for i=1:particleNum
                     temp=0;
                     for j=1:patternNum
                         temp=temp+GetDistance(m_pattern(j),Particle(i).location(ptDitrib(i,j)),disType);
                     end
                     if (temp==0)%最优解，直接退出
                         iter=iterNum+1;
                         break;
                     end
                     Particle(i).fitness=1/temp;
                 end
                 if(iter>iterNum)
                     break;
                 end
                 w=w_max-iter*(w_max-w_min)/iterNum;%更新权重系数
                 for i=1:particleNum %更新P_id,P_gd
                     if (Particle(i).fitness>P_id(i).fitness)
                         P_id(i).fitness=Particle(i).fitness;
                         P_id(i).location=Particle(i).location;
                         P_id(i).velocity=Particle(i).velocity;
                        if (Particle(i).fitness>P_gd(i).fitness)
                           P_gd(i).fitness=Particle(i).fitness;
                           P_gd(i).location=Particle(i).location;
                           P_gd(i).velocity=Particle(i).velocity;
                           P_gd.string=ptDitrib(i,:);
                         end
                     end
                 end
                 %更新粒子速度，位置
                 for i=1:particleNum
                     for j=1:centerNum
                         Particle(i).velocity(j).feature =...
                         w*Particle(i).velocity(j).feature+h1*rand(Nwidth,Nwidth).*...
                         (P_id(i).location(j).feature-Particle(i).location(j).feature)...
                         +h2*rand(Nwidth, Nwidth).*(P_gd.location(j).feature...
                         -Particle(i).location(j).feature);
                          Particle(i).location(j).feature= Particle(i).location(j).feature...
                          + Particle(i).velocity(j).feature;
                     end
                 end
                 %最近邻聚类
                 for i=1:particleNum
                     for j=1:patternNum
                         min=inf;
                         for k=1:centerNum
                             tempDis=GetDistance(m_pattern(j), Particle(i).location(k),disType);
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
         end
             
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         