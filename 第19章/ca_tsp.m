% ca_tsp.m
% ����·������
function ltsp=ca_tsp(n,c,dij)
i=1;
ltsp=dij(c(n),c(1));
while i<n;
    ltsp=ltsp+dij(c(i),c(i+1));
    i=i+1;
end
end