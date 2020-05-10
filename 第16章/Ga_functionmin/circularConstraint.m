function [c,ceq] = circularConstraint(x)
% Nonlinear constraint definition
% Define nonlinear equality constraint (none)
ceq = [];

% Define nonlinear inequality constraint
% circular region with radius 3: x1^2 + x^2 -3^2 <= 0 
c = x(:,1).^2 + x(:,2).^2 - 9;