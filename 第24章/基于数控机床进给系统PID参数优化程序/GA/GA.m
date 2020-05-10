%GA Program tooptimize PID Parameters
clear all;
close all;
size=30;
codel=3;
minx(1)=zeros(1);
maxx(1)=100*ones(1);
minx(2)=zeros(1);
maxx(2)=100*ones(1);
minx(3)=zeros(1);
maxx(3)=0*ones(1);
kpid(:,1)=minx(1)+(maxx(1)-minx(1))*rand(size,1);
kpid(:,2)=minx(2)+(maxx(2)-minx(2))*rand(size,1);
kpid(:,3)=minx(3)+(maxx(3)-minx(3))*rand(size,1);
G=100;
BsJ=0;
for kg=1:1:G
    time(kg)=kg;
for i=1:1:size
    kpidi=kpid(i,:);
    BsJ=pid_GA(kpidi);
 BsJi(i)=BsJ;
end
[OderJi,IndexJi]=sort(BsJi);
BestJ(kg)=OderJi(1);
BJ=BestJ(kg);
Ji=BsJi+1e-10;
fi=1./Ji;
[Oderfi,Indexfi]=sort(fi);
Bestfi=Oderfi(size);
BestS=kpid(Indexfi(size),:);
% select and reproduct operation
fi_sum=sum(fi);
fi_size=(Oderfi/fi_sum)*size;
fi_s=floor(fi_size);
r=size-sum(fi_s);
Rest=fi_size-fi_s;
[Restvalue,Index]=sort(Rest);
for i=size:-1:size-r+1
    fi_s(Index(i))=fi_s(Index(i))+1;
end
k=1;
for i=size:-1:1
    for j=1:1:fi_s(i)
    TempE(k,:)=kpid(Indexfi(i),:);
    k=k+1;
    end
end
% crossover operation
Pc=0.90;
for i=1:2:(size-1)
    temp=rand;
    if Pc>temp
        alfa=rand;
        TempE(i,:)=alfa*kpid(i+1,:)+(1-alfa)*kpid(i,:);
        TempE(i+1,:)=alfa*kpid(i,:)+(1-alfa)*kpid(i+1,:);
    end
end
TempE(size,:)=BestS;
kpid=TempE;
%Mution operation
Pm=0.1-[1:1:size]*(0.01)/size;
Pm_rand=rand(size,codel);
Mean=(maxx+minx)/2;
Dif=(maxx-minx);
for i=1:1:size 
    for j=1:1:codel
        if Pm(i)>Pm_rand(i,j)
            TempE(i,j)=Mean(j)+Dif(j)*(rand-0.5);
        end
    end
end
%guarantee TempE(size,:)belong tu the best individual
TempE(size,:)=BestS;
kpid=TempE;
end
Bestfi;
BestS;
Best_J=BestJ(G);
figure(1);
plot(time,BestJ,'LineWidth',3);
title('最优个体适应值','fontsize',10);
xlabel('迭代次数');ylabel('适应值');
grid on



        
