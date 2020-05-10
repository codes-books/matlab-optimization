%计算最终总路程
function L=Final_RouteLength(V,citys)
[xxx,order]=max(V);
New=citys(order,:);
New=[New;New(1,:)];
[rows,cs]=size(New);
L=0;
for i=2:rows
    L=L+dist(New(i-1,:),New(i,:)');
end
