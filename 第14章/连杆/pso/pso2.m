clc
clear all
N=40; %����Ⱥ��ģ
MaxDT=1000; %����������
w=0.7298; %����Ȩ��w
c1=1.49618; %ѧϰ����c1
c2=1.49618; %ѧϰ����c2
vmax=[1 1];
vmin=[-1 -1];
xmax=[7 7];
xmin=[1 1];
%�����ʼ�����ӵ�λ�ú��ٶ�
for i=1:N
    x(i,:)=6*rand(1,2); %0��10֮������������ͬ���Ҫ�ı䣩
    v(i,:)=rand(1,2);

    if violent1(x(i,:))<0    
        p(i,:)=x(i,:); %��ʼ��ʱ������λ����Ϊ��������λ��
    end
end

%������������ȷ������λ����Ӧ�Ⱥ���
Pbest=rand(1,2);
for i=1:N 
    if fitness2(p(i,:))<Pbest & violent1(p(i,:))<0  
         Pbest=fitness2(p(i,:));
         Pg=p(i,:);
     end
end

%���ݻ�������Ⱥ������ʽ����һ�ν������������м��Ӵ�midfor i=1:N
for t=MaxDT
    for i=1:N
        v(i,:)=w*v(i,:)+c1*rand*(p(i,:)-x(i,:))+c2*rand*(Pg-x(i,:));
        mid(i,:)=x(i,:)+v(i,:); %�м��mid
    end
 %%�ٶ�����%%
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

  mid(i,:)=x(i,:)+v(i,:); %�м��mid;%λ�ø���
%%λ������%%
    for i=1:N
       if mid(i,:)>xmax
               mid(i,:)=xmax;
        elseif mid(i,:)<xmin
                mid(i,:)=xmin;
            else
            end
        end
   
%�ж��м����ԭ����������(����ѡ��)
for i=1:N
 %����һ�����У���һ�������У���������ѡ����н�
 if violent1(x(i,:))<=0 && violent1(mid(i,:))>0
 NextGeneration(i,:)=x(i,:);
 end
 %�������У�ѡ����Ӧ��С�Ľ�����һ��
 if violent1(x(i,:))<=0 && violent1(mid(i,:))<=0
if fitness2(x(i,:))<=fitness2(mid(i,:))
 NextGeneration(i,:)=x(i,:);
else
 NextGeneration(i,:)=mid(i,:);
 end
 end
%����һ�����У���һ�������У���������ѡ����н�
 if violent1(x(i,:))>0 && violent1(mid(i,:))<=0
 NextGeneration(i,:)=mid(i,:);
 end
 %�������������У�ѡ��Υ��Լ��С�Ľ�����һ��
if violent1(x(i,:))>0 && violent1(mid(i,:))>0
 if violent1(x(i,:))<=violent1(mid(i,:))
 NextGeneration(i,:)=x(i,:);
 else
 NextGeneration(i,:)=mid(i,:);
 end
 end
end
 end

%NextGeneration���Ƹ����µ�����Ⱥx
x(i,:)=NextGeneration(i,:);
%���������ѭ��������������������Ż����
for t=1:MaxDT
 %���¸����ȫ������λ��
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
disp('������ȫ������λ��Ϊ��')
Solution=Pg
disp('�����ĸ�������λ��Ϊ��')
p(i,:)
disp('����������ֵΪ')
fitness2(p(i,:))
plot(y)
 xlabel('����');
 ylabel('��Ӧ��');