%¼ÆËãdu
function du=DeltaU(V,d,A,D)
[n,n]=size(V);
t1=repmat(sum(V,2)-1,1,n); % ¾ØÕó¸´ÖÆ
t2=repmat(sum(V,1)-1,n,1);
PermitV=V(:,2:n);
PermitV=[PermitV V(:,1)];
t3=d*PermitV;
du=-1*(A*t1+A*t2+D*t3);