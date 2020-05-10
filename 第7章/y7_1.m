clc,clear,close all
load('x.mat')
for j=1:42
    for i=1:38
       a(j,i)=(x(j,i+1)-x(j,i))/x(j,i); % 求增长率
    end
end

b=zeros(42,38);
c=zeros(42,25);
% 分别为不同增长率赋值
for j=1:42
    for i=1:38
       if  a(j,i)>=0.03
           b(j,i)=2;
       elseif (a(j,i)<0.03)&&(a(j,i)>0)
           b(j,i)=1;
       elseif  a(j,i)==0
           b(j,i)=0;    
       elseif  a(j,i)>-0.03 && a(j,i)<0
           b(j,i)=-1;
       elseif a(j,i)<-0.03
           b(j,i)=-2;   
       end
    end
end
% 统计相连增长率值特征
for j=1:42
for i=1:36
    if  (b(j,i)==2&&b(j,i+1)==2)
        c(j,1)=c(j,1)+1;
    elseif(b(j,i)==2&&b(j,i+1)==1)
        c(j,2)=c(j,2)+1;   
    elseif(b(j,i)==2&&b(j,i+1)==0)
        c(j,3)=c(j,3)+1;      
    elseif(b(j,i)==2&&b(j,i+1)==-1)
        c(j,4)=c(j,4)+1;
    elseif(b(j,i)==2&&b(j,i+1)==-2)
        c(j,5)=c(j,5)+1;
    elseif(b(j,i)==1&&b(j,i+1)==2)
        c(j,6)=c(j,6)+1;       
    elseif(b(j,i)==1&&b(j,i+1)==1)
        c(j,7)=c(j,7)+1;        
    elseif(b(j,i)==1&&b(j,i+1)==0)
        c(j,8)=c(j,8)+1;        
    elseif(b(j,i)==1&&b(j,i+1)==-1)
        c(j,9)=c(j,9)+1;       
    elseif(b(j,i)==1&&b(j,i+1)==-2)
        c(j,10)=c(j,10)+1;
    elseif(b(j,i)==0&&b(j,i+1)==2)
        c(j,11)=c(j,11)+1;       
    elseif(b(j,i)==0&&b(j,i+1)==1)
        c(j,12)=c(j,12)+1;        
    elseif(b(j,i)==0&&b(j,i+1)==0)
        c(j,13)=c(j,13)+1;      
    elseif(b(j,i)==0&&b(j,i+1)==-1)
        c(j,14)=c(j,14)+1;       
    elseif(b(j,i)==0&&b(j,i+1)==-2)
        c(j,15)=c(j,15)+1;     
    elseif(b(j,i)==-1&&b(j,i+1)==2)
        c(j,16)=c(j,16)+1;       
    elseif(b(j,i)==-1&&b(j,i+1)==1)
        c(j,17)=c(j,17)+1;       
    elseif(b(j,i)==-1&&b(j,i+1)==0)
        c(j,18)=c(j,18)+1;      
    elseif(b(j,i)==-1&&b(j,i+1)==-1)
        c(j,19)=c(j,19)+1;      
    elseif(b(j,i)==-1&&b(j,i+1)==-2)
        c(j,20)=c(j,20)+1;   
    elseif(b(j,i)==-2&&b(j,i+1)==2)
        c(j,21)=c(j,21)+1;       
    elseif(b(j,i)==-2&&b(j,i+1)==1)
        c(j,22)=c(j,22)+1;       
    elseif(b(j,i)==-2&&b(j,i+1)==0)
        c(j,23)=c(j,23)+1;        
    elseif(b(j,i)==-2&&b(j,i+1)==-1)
        c(j,24)=c(j,24)+1;        
    elseif(b(j,i)==-2&&b(j,i+1)==-2)
        c(j,25)=c(j,25)+1;       
    end
end
end
d=zeros(42,5);
% 累加求和
for i=1:42
    for j=1:25
        if(j<6)
            d(i,1)=d(i,1)+c(i,j);
        elseif(j>5&&j<11)
            d(i,2)=d(i,2)+c(i,j); 
        elseif(j>10&&j<16)
            d(i,3)=d(i,3)+c(i,j); 
        elseif(j>15&&j<21)
            d(i,4)=d(i,4)+c(i,j);
        else
            d(i,5)=d(i,5)+c(i,j);
        end
    end
end
%一步转移概率矩阵；
f=b(:,37);
e= zeros(5,5);
for i=1:42
    for j=1:25
        if(j<6)
            if(d(i,1)==0)
            e(5,j)=0;
            else
            e(1,j)=c(i,j)/d(i,1);    
            end
        elseif(j>5&&j<11)
            if(d(i,2)==0)
             e(5,j-5)=0;
            else
            e(2,j-5)=c(i,j)/d(i,2);    
            end
        elseif(j>10&&j<16)
            if(d(i,3)==0)
            e(5,j-10)=0; 
            else
            e(3,j-10)=c(i,j)/d(i,3);    
            end
        elseif(j>15&&j<21)
            if(d(i,4)==0)
            e(5,j-15)=0;
            else
            e(4,j-15)=c(i,j)/d(i,4);    
            end
        else
            if(d(i,5)==0)
            e(5,j-20)=0;
            else
            e(5,j-20)=c(i,j)/d(i,5);    
            end
        end
    end
    g=zeros(i,5); %预测4、5月的增长率
    if(f(i,1)==2)  
        h=[1 0 0 0 0 ]*e
        for k=1:6
            h=h*e            
        end
    elseif(f(i,1)==1)
        g(i,:)=[0 1 0 0 0 ];
        h=g(i,:)*e
        for k=1:6
            h=h*e           
        end
     elseif(f(i,1)==0)
        g(i,:)=[0 0 1 0 0 ];
        h=g(i,:)*e
        for k=1:6
            h=h*e            
        end   
     elseif(f(i,1)==-1)
        g(i,:)=[0 0 0 1 0 ];
        h=g(i,:)*e
        for k=1:6
            h=h*e            
        end      
     elseif(f(i,1)==-2)
        g(i,:)=[0 0 0 0 1 ];
        h=g(i,:)*e
        for k=1:6
            h=h*e            
        end      
    end
end
