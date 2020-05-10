close all
clc,clear
%%
x=0:0.1:1000;
k=1.01;
z=-k./(x*(pi+k))+1./50+1;
y=k./(x*(pi-k))-1./50+1;
hold on;
n=size(z);
for i=1:n(1,2)
    yz(1,i)=abs(y(1,i)-z(1,i));
end
[a,b]=min(yz);
j=1;
for i=b:n(1,2)
    xx(1,j)=x(1,i);
    yy(1,j)=y(1,i);
    zz(1,j)=z(1,i);
    j=j+1;
end
%%
semilogx(xx,yy,'r',xx,zz,'r');
%%
k=2;
xx=[];yy=[];zz=[];yz=[];z=[];y=[];
z=-k./(x*(pi+k))+1./50+1;
y=k./(x*(pi-k))-1./50+1;
for i=1:n(1,2)
    yz(1,i)=abs(y(1,i)-z(1,i));
end
[a,b]=min(yz);
j=1;
for i=b:n(1,2)
    xx(1,j)=x(1,i);
    yy(1,j)=y(1,i);
    zz(1,j)=z(1,i);
    j=j+1;
end
%%
semilogx(xx,yy,'b',xx,zz,'b');
%%
k=3;
xx=[];yy=[];zz=[];yz=[];z=[];y=[];
z=-k./(x*(pi+k))+1./50+1;
y=k./(x*(pi-k))-1./50+1;
for i=1:n(1,2)
    yz(1,i)=abs(y(1,i)-z(1,i));
end
[a,b]=min(yz);
j=1;
for i=b:n(1,2)
    xx(1,j)=x(1,i);
    yy(1,j)=y(1,i);
    zz(1,j)=z(1,i);
    j=j+1;
end
%%
semilogx(xx,yy,'g',xx,zz,'g');
axis([0.1 1000 0.98 1.05]);
set(gca,'xscale','log')
set(gca, 'XGrid', 'on');
set(gca, 'YGrid', 'on');
