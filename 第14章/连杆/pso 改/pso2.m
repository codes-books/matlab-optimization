clc,clear,close all
N=100; %����Ⱥ��ģ
MaxDT=1000; %����������
w=0.7298; %����Ȩ��w
c1=1.49618; %ѧϰ����c1
c2=1.49618; %ѧϰ����c2
vmax=[1 1];
vmin=[-1 -1];
xmax=[5 5];
xmin=[1 1];
%�����ʼ�����ӵ�λ�ú��ٶ�
j=1;
for i=1:N
    x(i,:)=5*rand(1,2); %0��10֮������������ͬ���Ҫ�ı䣩
%     v(i,:)=rand(1,2);
    if violent1(x(i,:))<0&&violent2(x(i,:))<0
        p(j,:)=x(i,:); %��ʼ��ʱ������λ����Ϊ��������λ��
        v(j,:)=rand(1,2);
        j=j+1;
    end
end
j=0;
x=[];x=p;
Np = size(p);
%������������ȷ������λ����Ӧ�Ⱥ���
Pbest=rand;
Pg=[4.5,2.3];
% for i=1:Np(1,1)
%      if fitness2(p(i,:)) < Pbest && violent1(x(i,:))<0 && violent2(x(i,:))<0  
%         Pbest=fitness2(p(i,:));
%         Pg=p(i,:);
%     end
% end

%���ݻ�������Ⱥ������ʽ����һ�ν������������м��Ӵ�midfor i=1:N
for t=1:MaxDT
    
    for i=1:Np
        v(i,:)=w*v(i,:)+c1*rand*(p(i,:)-x(i,:))+c2*rand*(Pg-x(i,:));
        mid(i,:)=x(i,:)+v(i,:); %�м��mid
    end
    
    %%�ٶ�����%%
    for i=1:Np
        if v(i,:)>vmax
            v(i,:)=vmax;
        elseif v(i,:)<vmin
             v(i,:)=vmin;
             else
        end
    end

    mid(i,:)=x(i,:)+v(i,:); %�м��mid;%λ�ø���
    %%λ������%%
    for i=1:Np
        if mid(i,:)>xmax
           mid(i,:)=xmax;
        elseif mid(i,:)<xmin
            mid(i,:)=xmin;
            else
        end
    end
   
    %�н���ѡ��
    for i=1:Np
         %����һ�����У���һ�������У���������ѡ����н�
         if (violent1(x(i,:))<=0&&violent2(x(i,:))<=0) && (violent1(mid(i,:))>0&&violent2(mid(i,:))>0)
            NextGeneration(i,:)=x(i,:);
         end

         %�������У�ѡ����Ӧ��С�Ľ�����һ��
         if (violent1(x(i,:))<=0&&violent2(x(i,:))<=0) && (violent1(mid(i,:))<=0&&violent2(mid(i,:))<=0)
            if fitness2(x(i,:))<=fitness2(mid(i,:))
                NextGeneration(i,:)=x(i,:);
            else
                NextGeneration(i,:)=mid(i,:);
            end
         end

        %����һ�����У���һ�������У���������ѡ����н�
         if (violent1(x(i,:))>0&&violent2(x(i,:))>0) && (violent1(mid(i,:))<=0&&violent2(mid(i,:))<=0)
            NextGeneration(i,:)=mid(i,:);
         end

        %�������������У�ѡ��Υ��Լ��С�Ľ�����һ��
        if (violent1(x(i,:))>0&&violent2(x(i,:))>0) && (violent1(mid(i,:))>0&&violent2(mid(i,:))>0)
             if violent1(x(i,:))<violent1(mid(i,:))&violent2(x(i,:))<violent2(mid(i,:))
                NextGeneration(i,:)=x(i,:);
             else
                NextGeneration(i,:)=mid(i,:);
             end
        end
    end

%NextGeneration���Ƹ����µ�����Ⱥx
x=NextGeneration;
%���������ѭ��������������������Ż����
Nx=size(x);
 %���¸����ȫ������λ��

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

disp('������ȫ������λ��Ϊ��')
Solution=Pg
disp('�����ĸ�������λ��Ϊ��')
p(i,:)
disp('����������ֵΪ')
Pbest
plot(y,'r','linewidth',2);
xlabel('��������');
ylabel('��Ӧ��');
title �������Ÿ�����Ӧ�ȡ���
grid on;axis tight