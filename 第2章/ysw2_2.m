clc,clear
A=1.1029;B=-1.4709;C=0.5941;D=0.848;E=3.8016;F=-0.25;G=0.0112;
f=100:-1:1;
S=A*(f.^2+B*f+C)./(f.^4+D*f.^3+E*f.^2+F*f+G);
plot(f,S,'.')
semilogx(f,S)
set(gca,'yscale','log') %y��Ϊlog
set(gca, 'XGrid', 'on'); %����
set(gca, 'YGrid', 'on'); %����
set(gca,'XDir','reverse') % ���÷���
