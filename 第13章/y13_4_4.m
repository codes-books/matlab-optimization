function DrawAckley()
    %绘制Ackley函数图形??
    x=[-8:0.1:8];
    y=x;
    [X,Y]=meshgrid(x,y);
    [row,col]=size(X);
    for l=1:col
        for h=1:row
            z(h,l)=Ackley([X(h,l),Y(h,l)]);
        end
    end
    mesh(X,Y,z);
    shading interp
end

function y=Ackley(x)
%Ackley?函数??
%输入x,给出相应的y值,在x=(0,0,…,0)?处有全局极小点0,为得到最大值，返回值取相反数??
[row,col]=size(x);
if row>1
    error('输入的参数错误');
end
y=-20*exp(-0.2*sqrt((1/col)*(sum(x.^2))))-exp((1/col)*sum(cos(2*pi.*x)))+exp(1)+20;
end