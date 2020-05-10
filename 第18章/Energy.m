% 计算能量函数
function E=Energy(V,d,A,D)
[n,n]=size(V);
t1=sumsqr(sum(V,2)-1);
t2=sumsqr(sum(V,1)-1);
PermitV=V(:,2:n);
PermitV=[PermitV V(:,1)];
temp=d*PermitV;
t3=sum(sum(V.*temp));
E=0.5*(A*t1+A*t2+D*t3);