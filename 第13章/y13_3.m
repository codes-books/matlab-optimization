%% 1维函数，全局最小寻优
% finding the mimimum value.
clc % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口
%% 目标方程
f = @(x) x.*sin(x) + x.*cos(2.*x);
%% 边界
lb = 0;  % 下限
ub = 10; % 上限
%% 找最小值 + 画图
x0 = [0 1 3 6 8 10];
hf = figure;
for i=1:6
    % fmincon：求多个变量的目标函数的最小值
    % fmincon(FUN,X,A,B,Aeq,Beq,LB,UB,NONLCON,options,varargin)
    x(i) = fmincon(f,x0(i),[],[],[],[],lb,ub,[],...
                   optimset('Algorithm','SQP','Disp','none'));
    subplot(2,3,i)
    ezplot(f,[lb ub]);
    hold on
    plot(x0(i),f(x0(i)),'k+')
    plot(x(i),f(x(i)),'ro')
    hold off
    title(['Starting at ',num2str(x0(i))]) %起始点 
    if i == 1 || i == 4
        ylabel('x sin(x) + x cos(2 x)')
    end
end
%% A common GOTCHA!
% 一维边界最小值问题 --- Solver: |fminbnd|.
x2 = fminbnd(f,lb,ub)% 单变量边界非线性函数最小求解
figure
ezplot(f,[lb ub]);
hold on
plot(x2,f(x2),'ro')
hold off
ylabel('x sin(x) + x cos(2 x)')
title({'Solution using fminbnd.','Required no starting point!'})
%% 使用globalSearch or MultiStart寻优
problem = createOptimProblem('fmincon','objective',f,'x0',x0(1),'lb',lb,...
             'ub',ub,'options',optimset('Algorithm','SQP','Disp','none'));
gs = GlobalSearch; % 全局寻优
xgs = run(gs,problem); % 执行当前路径 --> Use CD or ADDPATH to make the script executable from the prompt
figure,
ezplot(f,[lb ub]);
hold on
plot(xgs,f(xgs),'ro')
hold off
ylabel('x sin(x) + x cos(2 x)')
title('Solution using globalSearch.')