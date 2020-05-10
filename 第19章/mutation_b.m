% ±äÒì²ßÂÔB£¬mutation_b
function cnew=mutation_b(c0,n)
j1=ceil(rand*n);
cnew=c0;
if j1<n
    cnew(j1)=c0(j1+1);
    cnew(j1+1)=c0(j1);
else
    cnew(j1)=c0(1);
    cnew(1)=c0(j1);  
end