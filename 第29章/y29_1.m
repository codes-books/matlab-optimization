clc % ����
clear all; % ɾ��workplace����
close all; % �ص���ʾͼ�δ���
format short
% Initial
%% gridtop()�������˽ṹ
pos = gridtop(2,3)
figure,plotsom(pos)
grid on
%% Hextop()��������һ����������ʽ�����˽ṹ
pos = hextop(2,3)
figure,plotsom(pos)
grid on
%% 8*10 ��Ԫ���˽ṹ��������������Ԫ����ͼ��
pos = hextop(8,10)
figure,plotsom(pos)
grid on
%% randtop()�������ɵ���Nά�����ʽ�ֲ�����Ԫ���˽ṹ
pos = randtop(2,3)
figure,plotsom(pos)
grid on
pos = randtop(8,10)
figure,plotsom(pos)
grid on
%% ��Ԫ֮��ľ���
% dist() ����ŷ����þ���
% boxdist()
% mandist()
% ÿ����������ͬ�ľ�����㷽��������Ԫ���ڽ���Ԫ֮��ľ���
clear
pos = gridtop(2,3)
figure,plotsom(pos)
grid on
d1 = dist(pos)
d2 = boxdist(pos)
d3 = mandist(pos) % �����پ���











