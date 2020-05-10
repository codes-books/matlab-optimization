clc
clear all
N=40; %粒子群规模
MaxDT=1000; %最大迭代次数
w=0.7298; %惯性权重w
c1=1.49618; %学习因子c1
c2=1.49618; %学习因子c2
vmax=[1 1];
vmin=[-1 -1];
xmax=[7 7];
xmin=[1 1];
%随机初始化粒子的位置和速度
for i=1:N
    x(i,:)=6*rand(1,2); %0到10之间的随机数（不同情况要改变）
    v(i,:)=rand(1,2);

    if violent1(x(i,:))<0    
        p(i,:)=x(i,:); %初始化时把粒子位置设为个体最优位置
    end
end

%根据两个函数确定最优位置适应度函数
Pbest=rand(1,2);
for i=1:N 
    if fitness2(p(i,:))<Pbest & violent1(p(i,:))<0  
         Pbest=fitness2(p(i,:));
         Pg=p(i,:);
     end
end

%根据基本粒子群迭代公式进行一次进化迭代产生中间子代midfor i=1:N
for t=MaxDT
    for i=1:N
        v(i,:)=w*v(i,:)+c1*rand*(p(i,:)-x(i,:))+c2*rand*(Pg-x(i,:));
        mid(i,:)=x(i,:)+v(i,:); %中间代mid
    end
 %%速度限制%%
    jj=1;
    for i=1:N
       if v(i,:)>vmax 
             K(jj)=vmax/v(i,:);
             jj=jj+1;
         elseif v(i,:)<vmin
             K(jj)=vmin/v(i,:);
             jj=jj+1;
       end
    end   
    Kmin=min(K);
    for i=1:N
         if v(i,:)>vmax
                v(i,:)=v(i,:)*Kmin;
          elseif v(i,:)<vmin
                 v(i,:)=v(i,:)*Kmin;
                else
         end
     end

  mid(i,:)=x(i,:)+v(i,:); %中间代mid;%位置更新
%%位置限制%%
    for i=1:N
       if mid(i,:)>xmax
               mid(i,:)=xmax;
        elseif mid(i,:)<xmin
                mid(i,:)=xmin;
            else
            end
        end
   
%判断中间代与原父代的优劣(进化选择)
for i=1:N
 %若都一个可行，另一个不可行，则无条件选择可行解
 if violent1(x(i,:))<=0 && violent1(mid(i,:))>0
 NextGeneration(i,:)=x(i,:);
 end
 %若都可行，选择适应度小的进入下一代
 if violent1(x(i,:))<=0 && violent1(mid(i,:))<=0
if fitness2(x(i,:))<=fitness2(mid(i,:))
 NextGeneration(i,:)=x(i,:);
else
 NextGeneration(i,:)=mid(i,:);
 end
 end
%若都一个可行，另一个不可行，则无条件选择可行解
 if violent1(x(i,:))>0 && violent1(mid(i,:))<=0
 NextGeneration(i,:)=mid(i,:);
 end
 %若两个都不可行，选择违背约束小的进入下一代
if violent1(x(i,:))>0 && violent1(mid(i,:))>0
 if violent1(x(i,:))<=violent1(mid(i,:))
 NextGeneration(i,:)=x(i,:);
 else
 NextGeneration(i,:)=mid(i,:);
 end
 end
end
 end

%NextGeneration复制给更新的粒子群x
x(i,:)=NextGeneration(i,:);
%下面进入主循环，迭代最大次数后输出优化结果
for t=1:MaxDT
 %更新个体和全局最优位置
 for i=1:N
 if fitness2(x(i,:))<fitness2(p(i,:))
 p(i,:)=x(i,:);
 end
 if fitness2(p(i,:))<Pbest && violent1(p(i,:))<=0
    Pbest= fitness2(p(i,:));
 Pg=p(i,:);
 end
 end
 y(t)=fitness2(p(i,:));
  end
disp('函数的全局最优位置为：')
Solution=Pg
disp('函数的个体最优位置为：')
p(i,:)
disp('函数的最优值为')
fitness2(p(i,:))
plot(y)
 xlabel('代数');
 ylabel('适应度');