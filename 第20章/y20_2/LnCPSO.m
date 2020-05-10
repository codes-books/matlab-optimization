function [xm,fv] = LnCPSO(fitness,N,cmax,cmin,w,M,D)

format long;

%------��ʼ����Ⱥ�ĸ���------------

for i=1:N

    for j=1:D

        x(i,j)=randn;  %�����ʼ��λ��

        v(i,j)=randn;  %�����ʼ���ٶ�

    end

end

%------�ȼ���������ӵ���Ӧ�ȣ�����ʼ��Pi��Pg----------------------

for i=1:N

    p(i)=fitness(x(i,:));

    y(i,:)=x(i,:);

end

pg = x(N,:);             %PgΪȫ������

for i=1:(N-1)

    if fitness(x(i,:))<fitness(pg)

        pg=x(i,:);

    end

end

%------������Ҫѭ�������չ�ʽ���ε���------------

for t=1:M

    c = cmax - (cmax - cmin)*t/M;
    
    for i=1:N

        v(i,:)=w*v(i,:)+c*rand*(y(i,:)-x(i,:))+c*rand*(pg-x(i,:));

        x(i,:)=x(i,:)+v(i,:);

        if fitness(x(i,:))<p(i)

            p(i)=fitness(x(i,:));

            y(i,:)=x(i,:);

        end

        if p(i)<fitness(pg)

            pg=y(i,:);

        end

    end

    Pbest(t)=fitness(pg);
end
r=[1:1:100];
plot(r,Pbest,'r--');
xlabel('��������')
ylabel('��Ӧ��ֵ')
title('�Ľ�PSO�㷨��������')
legend('ͬ���仯ѧϰ����PSO�㷨')
hold on
xm = pg';
fv = fitness(pg);



