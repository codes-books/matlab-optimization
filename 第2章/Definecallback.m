function Definecallback
hfig=figure('units','normalize',...
'position',[0.4,0.4,0.3,0.2]);
%�ڴ����д�����ť�ؼ�����������callback����ֵΪ�ַ�����
hpush=uicontrol('parent',hfig,...
 'style','pushbutton',...
 'string','execute callback',...
'units','normalize',...
'position',[0.4,0.4,0.3,0.2]);
%���ð�ť��callback����
set(hpush,'callback',@mycallback);
%����ص�����Ϊ�Ӻ���
function mycallback(hobj,event)
figure;
x=0:0.1:pi;
y=sin(x);
plot(x,y);
