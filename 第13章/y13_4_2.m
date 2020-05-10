% %% ������Ժ���
% % finding the mimimum value.
% clc % ����
% clear all; % ɾ��workplace����
% close all; % �ص���ʾͼ�δ���
function DrawRastrigin()
    % ����Rastrigin����ͼ��
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
    % Rastrigin����
    % ����x,������Ӧ��yֵ,��x = ( 0 , 0 ,��, 0 )����ȫ�ּ�С��0.
    [row,col] = size(x);
    if  row > 1 
        error( ' ����Ĳ������� ' );
    end
    y = sum(x.^2 - 10 * cos( 2 * pi * x) + 10 );
    y =y;
end