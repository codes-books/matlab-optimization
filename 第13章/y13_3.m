%% 1ά������ȫ����СѰ��
% finding the mimimum value.
clc % ����
clear all; % ɾ��workplace����
close all; % �ص���ʾͼ�δ���
%% Ŀ�귽��
f = @(x) x.*sin(x) + x.*cos(2.*x);
%% �߽�
lb = 0;  % ����
ub = 10; % ����
%% ����Сֵ + ��ͼ
x0 = [0 1 3 6 8 10];
hf = figure;
for i=1:6
    % fmincon������������Ŀ�꺯������Сֵ
    % fmincon(FUN,X,A,B,Aeq,Beq,LB,UB,NONLCON,options,varargin)
    x(i) = fmincon(f,x0(i),[],[],[],[],lb,ub,[],...
                   optimset('Algorithm','SQP','Disp','none'));
    subplot(2,3,i)
    ezplot(f,[lb ub]);
    hold on
    plot(x0(i),f(x0(i)),'k+')
    plot(x(i),f(x(i)),'ro')
    hold off
    title(['Starting at ',num2str(x0(i))]) %��ʼ�� 
    if i == 1 || i == 4
        ylabel('x sin(x) + x cos(2 x)')
    end
end
%% A common GOTCHA!
% һά�߽���Сֵ���� --- Solver: |fminbnd|.
x2 = fminbnd(f,lb,ub)% �������߽�����Ժ�����С���
figure
ezplot(f,[lb ub]);
hold on
plot(x2,f(x2),'ro')
hold off
ylabel('x sin(x) + x cos(2 x)')
title({'Solution using fminbnd.','Required no starting point!'})
%% ʹ��globalSearch or MultiStartѰ��
problem = createOptimProblem('fmincon','objective',f,'x0',x0(1),'lb',lb,...
             'ub',ub,'options',optimset('Algorithm','SQP','Disp','none'));
gs = GlobalSearch; % ȫ��Ѱ��
xgs = run(gs,problem); % ִ�е�ǰ·�� --> Use CD or ADDPATH to make the script executable from the prompt
figure,
ezplot(f,[lb ub]);
hold on
plot(xgs,f(xgs),'ro')
hold off
ylabel('x sin(x) + x cos(2 x)')
title('Solution using globalSearch.')