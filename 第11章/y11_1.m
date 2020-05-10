% RBF Network approximation
clc% 清屏
clear all;%删除workplace变量
close all;%关掉显示图形窗口
% 网络学习参数
alfa=0.08; %动量因子
xite=0.7;   %学习因子   
x=[0,0]';

b=1.5*ones(4,1);   
c=0.5*ones(2,4);   
w=rands(4,1);   

w_1=w;
w_2=w_1;
c_1=c;
c_2=c_1;
b_1=b;
b_2=b_1;
d_w=0*w;
d_b=0*b;
y_1=0;

ts=0.001;
for k=1:1:2000
   
    time(k)=k*ts;
    u(k)=0.50*sin(1*2*pi*k*ts);

    y(k)=u(k)^3+y_1/(1+y_1^2);  

    x(1)=u(k); %初值
    x(2)=y(k);

    for j=1:1:4
        h(j)=exp(-norm(x-c(:,j))^2/(2*b(j)*b(j)));% 高斯基函数
    end
    ym(k)=w'*h';
    em(k)=y(k)-ym(k);

    for j=1:1:4
        d_w(j)=xite*em(k)*h(j);
        d_b(j)=xite*em(k)*w(j)*h(j)*(b(j)^-3)*norm(x-c(:,j))^2;
        for i=1:1:2
            d_c(i,j)=xite*em(k)*w(j)*h(j)*(x(i)-c(i,j))*(b(j)^-2);
        end
    end
   w=w_1+ d_w+alfa*(w_1-w_2);
   b=b_1+d_b+alfa*(b_1-b_2);
   c=c_1+d_c+alfa*(c_1-c_2);
   
%%%%%%%%%%%%%%%%%%%Jacobian信息%%%%%%%%%%%%%%%%%%%%
    yu=0;
    for j=1:1:4
        yu=yu+w(j)*h(j)*(c(1,j)-x(1))/b(j)^2; % 敏感度
    end
    dyu(k)=yu;

    y_1=y(k);

    w_2=w_1;
    w_1=w;

    c_2=c_1;
    c_1=c;

    b_2=b_1;
    b_1=b;
end
figure(1);
plot(time,y,'r',time,ym,'b'); % RBF网络辨识结果
xlabel('time(s)');ylabel('y and ym');
grid on
title('RBF网络辨识结果')  
figure(2);
plot(time,y-ym,'r'); % RBF网络辨识误差
xlabel('time(s)');ylabel('identification error');
grid on
title('RBF网络辨识误差')
figure(3);
plot(time,dyu,'r');   % RBF网络敏感度Jacobian信息
xlabel('times');ylabel('dyu');
grid on
title('RBF网络敏感度Jacobian信息')