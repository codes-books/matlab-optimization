% %% 经典测试函数
% % finding the mimimum value.
% clc % 清屏
% clear all; % 删除workplace变量
% close all; % 关掉显示图形窗口
function y10_4
    % 绘制Griewank函数图形
    x = [-20 : 0.3 : 20];
    y = x;
    [X,Y] = meshgrid(x,y);
    [row,col] = size(X);
    for l = 1 :col
        for h = 1 :row
            z(h,l) = Griewank([X(h,l),Y(h,l)]);
        end
    end
    mesh(X,Y,z);
    view([-15.5 30]);
    shading interp
end


function y=Griewank(x)
% Griewan函数
% 输入x,给出相应的y值,在x = ( 0 , 0 ,…, 0 )处有全局极小点0.
[row,col] = size(x);
if  row > 1
    error( ' 输入的参数错误 ' );
end
y1 = 1 / 4000 * sum(x.^2 );
y2 = 1 ;
for  h = 1 :col
    y2 = y2 * cos(x(h) / sqrt(h));
end
y = y1 - y2 + 1 ;
y =- y;

end
