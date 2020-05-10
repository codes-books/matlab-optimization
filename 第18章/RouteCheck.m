% 标准化路径，并检查路径合法性，要求每行每列只有一个“1”
function [V1,CheckR]=RouteCheck(V)
[rows,cols]=size(V);
V1=zeros(rows,cols);
[XC,Order]=max(V);
for j=1:cols
    V1(Order(j),j)=1;
end
C=sum(V1);
R=sum(V1');
CheckR=sumsqr(C-R);