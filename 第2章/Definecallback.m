function Definecallback
hfig=figure('units','normalize',...
'position',[0.4,0.4,0.3,0.2]);
%在窗口中创建按钮控件，并设置其callback属性值为字符数组
hpush=uicontrol('parent',hfig,...
 'style','pushbutton',...
 'string','execute callback',...
'units','normalize',...
'position',[0.4,0.4,0.3,0.2]);
%设置按钮的callback属性
set(hpush,'callback',@mycallback);
%定义回调函数为子函数
function mycallback(hobj,event)
figure;
x=0:0.1:pi;
y=sin(x);
plot(x,y);
