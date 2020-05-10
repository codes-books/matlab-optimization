%% |peaks| Minimization with Genetic Algorithm
%% Objective Function
% find the minimum of the |peaks| function
clc % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口

peaks

%% Nonlinear Constraint Function
% Subject to a nonlinear constraint defined by a circular region of radius
% three around the origin
type circularConstraint

%% Define Optimization Problem
problem = createOptimProblem('fmincon',...
                             'objective',@(x) peaks(x(:,1),x(:,2)), ...
                             'nonlcon',@circularConstraint,...
                             'x0',[-1 -1],...
                             'lb',[-3 -3],...
                             'ub',[3 3],...
                             'options',optimset('OutputFcn',...
                                                @peaksPlotIterates))
                             
%% Run the solver |fmincon| from the inital point
% We can see the solution is not the global minimum
[x,f] = fmincon(problem)                                                    

%% Use Genetic Algorithm to Find the Global Minimum
% Solve the problem using ga.
problem.solver  = 'ga';
problem.fitnessfcn = problem.objective;
problem.nvars = 2;
problem.options = gaoptimset('PopInitRange',[-3;3],...
                             'OutputFcn',@peaksPlotIterates,...
                             'Display','iter')

[x,f] = ga(problem)