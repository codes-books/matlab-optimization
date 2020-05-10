%计算初始总路程
function L0=Initial_RouteLength(citys)
citys=[citys;citys(1,:)];
[r,c]=size(citys);
L0=0;
for i=2:r
    L0=L0+dist(citys(i-1,:),citys(i,:)');
end