% ½»²æ²ßÂÔD£¬cross_tsp_d
function cnew=cross_tsp_d(c1,c2,n)
j1=ceil(n*rand);
j2=ceil(n*rand);
j3=min(j1,j2);
j4=max(j1,j2);
clear c3
c3=c2(j3:j4);
j5=find(c1==c3(1));
k=1;
for i=1:j5-1
   if(isempty(find(c3==c1(i))));
       cnew(k)=c1(i);
       k=k+1;
   end
end
cnew(k:k+j4-j3)=c3;
k=k+j4-j3+1;
for i=j5:n
    if(isempty(find(c3==c1(i))))
        cnew(k)=c1(i);
        k=k+1;
    end
end















