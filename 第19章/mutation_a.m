% ±äÒì²ßÂÔA£¬mutation_a
function cnew=mutation_a(c0,n)
j1=ceil(n*rand);
j2=ceil(n*rand);
cnew=c0;
cnew(j1)=c0(j2);
cnew(j2)=c0(j1);
