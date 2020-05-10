% Fuzzy RBF Approaching
clc % 清屏
clear all; % 删除workplace变量
close all; % 关掉显示图形窗口

xite=0.20; % 学习因子  
alfa=0.05; % 动量因子

b=5*ones(5,1);
c=[-5 -2 0 2 5;
    -5 -2 0 2 5];
w=rands(25,1);

c_1=c;
c_2=c_1;

b_1=b;
b_2=b_1;

w_1=w;
w_2=w_1;

u_1=0.0;
y_1=0.0;

ts=0.001;
for k=1:1:1000
time(k)=k*ts;
   
u(k)=0.5*sin(6*pi*k*ts);
y(k)=u_1^3+y_1/(1+y_1^2);

% Layer1:input
x=[u(k),y(k)]';                     
f1=x;                        

% Layer2:fuzzation
for i=1:1:2                        
   for j=1:1:5
      net2(i,j)=-(f1(i)-c(i,j))^2/b(j)^2;
   end
end
for i=1:1:2
   for j=1:1:5
   f2(i,j)=exp(net2(i,j));
   end
end

% Layer3:fuzzy inference(49 rules)
for j=1:1:5                  
    m1(j)=f2(1,j);
	 m2(j)=f2(2,j);
end

for i=1:1:5
	for j=1:1:5
   	 ff3(i,j)=m2(i)*m1(j);
	end
end
f3=[ff3(1,:),ff3(2,:),ff3(3,:),ff3(4,:),ff3(5,:)];

% Layer4:output
f4=w_1'*f3';                  
ym(k)=f4;                   

e(k)=y(k)-ym(k);

d_w=0*w_1;
for j=1:1:25
    d_w(j)=xite*e(k)*f3(j);
end
w=w_1+d_w+alfa*(w_1-w_2);
 
delta2=-e(k)*w'*f3';;

d_b=0*b_1;
for j=1:1:5
    d_b(j)=xite*delta2*2*((x(1)-c(1,j))^2)*(b(j)^-3);
end
b=b_1+d_b+alfa*(b_1-b_2);
%%%%%
d_c=0*c_1;
for i=1:1:2
    for j=1:1:5
	    d_c(i,j)=-xite*delta2*2*(x(i)-c(i,j))*b(j)^-2;
    end
end
c=c_1+d_c+alfa*(c_1-c_2);
    
   u_1=u(k);
   y_1=y(k);
   
   w_2=w_1;
   w_1=w;
   
   c_2=c_1;
   c_1=c;
   
   b_2=b_1;
   b_1=b;
end
figure(1);
plot(time,y,'r',time,ym,'b');
xlabel('time(s)');ylabel('Approaching');
grid on
title('模糊RBF网络逼近效果')
figure(2);
plot(time,y-ym,'r');
xlabel('time(s)');ylabel('Approaching error');
grid on
title('模糊RBF网络逼近误差')