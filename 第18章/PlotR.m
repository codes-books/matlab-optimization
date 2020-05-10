% Â·¾¶Ñ°ÓÅ×÷Í¼
function PlotR(V,citys)
figure;
citys_origin=citys;
citys=[citys;citys(1,:)];
[xxx,order]=max(V);
New=citys(order,:);
New=[New;New(1,:)];

subplot(1,2,1)
plot(citys(1,1),citys(1,2),'*')     % first city
hold on
plot(citys(2,1),citys(2,2),'+')     % second city
hold on
plot(citys(:,1),citys(:,2),'o-')
for i=1:length(citys_origin)
    text(citys_origin(i,1),citys_origin(i,2),['   ' num2str(i)])
end
xlabel('X axis')
ylabel('Y axis')
title('Original Route')
axis([0 1 0 1])
grid on

subplot(1,2,2)
plot(New(1,1),New(1,2),'*')       % first city
hold on
plot(New(2,1),New(2,2),'+')       % second city
hold on
plot(New(:,1),New(:,2),'o-')
for i=1:length(citys_origin)
    text(citys_origin(i,1),citys_origin(i,2),['  ' num2str(i)])
end
xlabel('X axis')
ylabel('Y axis')
title('TSP solution')
axis([0 1 0 1])
axis on
grid on
