% %% 经典测试函数
% % finding the mimimum value.
% clc % 清屏
% clear all; % 删除workplace变量
% close all; % 关掉显示图形窗口
function DrawRastrigin()
    % 绘制Rastrigin函数图形
    x = [-5 : 0.05 : 5 ];
    y = x;
    [X,Y] = meshgrid(x,y);
    [row,col] = size(X);
    for  l = 1 :col
         for  h = 1 :row
            z(h,l) = Rastrigin([X(h,l),Y(h,l)]);
        end
    end
    mesh(X,Y,z);
    shading interp
end

function y = Rastrigin(x)
    % Rastrigin函数
    % 输入x,给出相应的y值,在x = ( 0 , 0 ,…, 0 )处有全局极小点0.
    [row,col] = size(x);
    if  row > 1 
        error( ' 输入的参数错误 ' );
    end
    y = sum(x.^2 - 10 * cos( 2 * pi * x) + 10 );
    y =y;
end