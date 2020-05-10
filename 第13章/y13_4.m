% %% ������Ժ���
% % finding the mimimum value.
% clc % ����
% clear all; % ɾ��workplace����
% close all; % �ص���ʾͼ�δ���
function y10_4
    % ����Griewank����ͼ��
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
% Griewan����
% ����x,������Ӧ��yֵ,��x = ( 0 , 0 ,��, 0 )����ȫ�ּ�С��0.
[row,col] = size(x);
if  row > 1
    error( ' ����Ĳ������� ' );
end
y1 = 1 / 4000 * sum(x.^2 );
y2 = 1 ;
for  h = 1 :col
    y2 = y2 * cos(x(h) / sqrt(h));
end
y = y1 - y2 + 1 ;
y =- y;

end
