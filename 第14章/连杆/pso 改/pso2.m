clc,clear,close all
N=100; %粒子群规模
MaxDT=1000; %最大迭代次数
w=0.7298; %惯性权重w
c1=1.49618; %学习因子c1
c2=1.49618; %学习因子c2
vmax=[1 1];
vmin=[-1 -1];
xmax=[5 5];
xmin=[1 1];
%随机初始化粒子的位置和速度
j=1;
for i=1:N
    x(i,:)=5*rand(1,2); %0到10之间的随机数（不同情况要改变）
%     v(i,:)=rand(1,2);
    if violent1(x(i,:))<0&&violent2(x(i,:))<0
        p(j,:)=x(i,:); %初始化时把粒子位置设为个体最优位置
        v(j,:)=rand(1,2);
        j=j+1;
    end
end
j=0;
x=[];x=p;
Np = size(p);
%根据两个函数确定最优位置适应度函数
Pbest=rand;
Pg=[4.5,2.3];
% for i=1:Np(1,1)
%      if fitness2(p(i,:)) < Pbest && violent1(x(i,:))<0 && violent2(x(i,:))<0  
%         Pbest=fitness2(p(i,:));
%         Pg=p(i,:);
%     end
% end

%根据基本粒子群迭代公式进行一次进化迭代产生中间子代midfor i=1:N
for t=1:MaxDT
    
    for i=1:Np
        v(i,:)=w*v(i,:)+c1*rand*(p(i,:)-x(i,:))+c2*rand*(Pg-x(i,:));
        mid(i,:)=x(i,:)+v(i,:); %中间代mid
    end
    
    %%速度限制%%
    for i=1:Np
        if v(i,:)>vmax
            v(i,:)=vmax;
        elseif v(i,:)<vmin
             v(i,:)=vmin;
             else
        end
    end

    mid(i,:)=x(i,:)+v(i,:); %中间代mid;%位置更新
    %%位置限制%%
    for i=1:Np
        if mid(i,:)>xmax
           mid(i,:)=xmax;
        elseif mid(i,:)<xmin
            mid(i,:)=xmin;
            else
        end
    end
   
    %判进化选择
    for i=1:Np
         %若都一个可行，另一个不可行，则无条件选择可行解
         if (violent1(x(i,:))<=0&&violent2(x(i,:))<=0) && (violent1(mid(i,:))>0&&violent2(mid(i,:))>0)
            NextGeneration(i,:)=x(i,:);
         end

         %若都可行，选择适应度小的进入下一代
         if (violent1(x(i,:))<=0&&violent2(x(i,:))<=0) && (violent1(mid(i,:))<=0&&violent2(mid(i,:))<=0)
            if fitness2(x(i,:))<=fitness2(mid(i,:))
                NextGeneration(i,:)=x(i,:);
            else
                NextGeneration(i,:)=mid(i,:);
            end
         end

        %若都一个可行，另一个不可行，则无条件选择可行解
         if (violent1(x(i,:))>0&&violent2(x(i,:))>0) && (violent1(mid(i,:))<=0&&violent2(mid(i,:))<=0)
            NextGeneration(i,:)=mid(i,:);
         end

        %若两个都不可行，选择违背约束小的进入下一代
        if (violent1(x(i,:))>0&&violent2(x(i,:))>0) && (violent1(mid(i,:))>0&&violent2(mid(i,:))>0)
             if violent1(x(i,:))<violent1(mid(i,:))&violent2(x(i,:))<violent2(mid(i,:))
                NextGeneration(i,:)=x(i,:);
             else
                NextGeneration(i,:)=mid(i,:);
             end
        end
    end

%NextGeneration复制给更新的粒子群x
x=NextGeneration;
%下面进入主循环，迭代最大次数后输出优化结果
Nx=size(x);
 %更新个体和全局最优位置

     for i=1:Nx
         if fitness2(x(i,:))<fitness2(p(i,:))&& violent1(p(i,:))<=0&& violent2(p(i,:))<=0
            p(i,:)=x(i,:);
         end
         if fitness2(p(i,:))<Pbest && violent1(p(i,:))<=0&& violent2(p(i,:))<=0
            Pbest= fitness2(p(i,:));
            Pg=p(i,:); 
         end
     end
     
    y(t)=Pbest; %fitness2(Pg)
 end

disp('函数的全局最优位置为：')
Solution=Pg
disp('函数的个体最优位置为：')
p(i,:)
disp('函数的最优值为')
Pbest
plot(y,'r','linewidth',2);
xlabel('进化代数');
ylabel('适应度');
title （‘最优个体适应度’）
grid on;axis tight