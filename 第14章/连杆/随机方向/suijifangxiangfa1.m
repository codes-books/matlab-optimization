clc
clear all
n=2;Nmax=100;
e=0.0000001;e1=0.001;a0=0.1;
x0=[4 2];
f0=e*fun0(x0);;
a=a0;
for i=1:100
    jj=0;
    time(i)=i;
    for k=1:Nmax
        r=rand(1,2);
        s=2*r-1;
        s=s./sqrt(s.^2);
        x=x0+a*s;
        for j=1:100
            if (g1(x)<0)||(g2(x)<0)
                break
            end
            f=e*fun0(x);
            if f<f0
                break
            end
            x0=x;f0=f;jj=1;
            x=x0+a*s;
        end
        if jj==1
            break
        end
        end
        Y2(i)=e*fun0(x);
        if abs(Y2(i))<=e1
            break
        end
        if a<=e
            break
        end
        if jj==0
            a=0.5*a;
        end
end
disp '最优点x'
x
disp '目标函数f'
Y2
disp '最优值'
min(Y2)
disp '约束条件g1   '
g1(x)  
disp '约束条件 g2 '
g2(x)
plot(Y2,'r','linewidth',2);
xlabel('迭代的次数');ylabel('适应度值P_g');
title('约束随机方向法')
hold on;
axis tight