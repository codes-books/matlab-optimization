%����Ⱥ�����㷨
function [m_pattern]=C_PSO(m_pattern,patternNum)
%         disType=DisSelDlg();%��þ��������
        % [centerNum iterNum]=InputClassDlg;%�����������������������
%         patternNum=12;
disType=1;
centerNum=6;%��������
iterNum=20;%����������
        particleNum=200;%��ʼ��������
         %��ʼ�����ĺ��ٶ�
         global Nwidth;
         for i=1:centerNum
             m_center(i).feature=zeros(Nwidth,Nwidth);
             m_center(i).patternNum=0;
             m_center(i).index=i;
             m_velocity(i).feature=zeros(Nwidth, Nwidth);
             for i=1:particleNum
                 Particle(i).location=m_center;%���Ӹ�����
                 Particle(i).velocity=m_velocity;%���Ӹ������ٶ�
                 Particle(i).fitness=0;%��Ӧ��
                 P_id(i).velocity=m_velocity;%���������ٶ�
                 P_id(i).location=m_center;%������������
                 P_id(i).fitness=0;%����������Ӧ��
             end
             P_gd.location=m_center;%ȫ��������������
             P_gd.velocity=m_velocity;%ȫ�����������ٶ�
             P_gd.fitness=0;%����ȫ��������Ӧ��
             P_gd.string=zeros(1,patternNum);
             ptDitrib=zeros(particleNum,patternNum);%��ʼ�����ӷֲ�����
             for i=1:particleNum %����������ӷֲ�����
                 ptDitrib(i,:)=randperm(patternNum);
                 for j=1:patternNum
                     if (ptDitrib(i,j)>centerNum)
                         ptDitrib(i,j)=fix(rand*centerNum+1);
                     end
                 end
             end
             %������ʼ����Ⱥ
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
                 %����������Ӧ��
                 for i=1:particleNum
                     temp=0;
                     for j=1:patternNum
                         temp=temp+GetDistance(m_pattern(j),Particle(i).location(ptDitrib(i,j)),disType);
                     end
                     if (temp==0)%���Ž⣬ֱ���˳�
                         iter=iterNum+1;
                         break;
                     end
                     Particle(i).fitness=1/temp;
                 end
                 if(iter>iterNum)
                     break;
                 end
                 w=w_max-iter*(w_max-w_min)/iterNum;%����Ȩ��ϵ��
                 for i=1:particleNum %����P_id,P_gd
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
                 %���������ٶȣ�λ��
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
                 %����ھ���
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
                     %���¼����������
                     for j=1:centerNum
                         Particle(i).location(j)=CalCenter(Particle(i).location(j),m_pattern,patternNum);
                     end
                 end
                 for i=1:patternNum
                     m_pattern(i).category=P_gd.string(1,i);
                 end
             end
         end
             
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         