% ±äÒì²ßÂÔD£¬mutation_d
function cnew=mutation_d(c0,n)
j1=ceil(n*rand);
j2=ceil(n*rand);
j3=min(j1,j2);
j4=max(j1,j2);
cnew=c0;
% k=1;
if j4>j3
    k=1;
    while k<=j4-j3
        cnew(j3+k-1)=c0(j3+k);
        k=k+1;
    end
    cnew(j4)=c0(j3);
end