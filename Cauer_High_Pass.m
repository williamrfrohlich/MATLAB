%-----------------------------------------------------
%---	Author: Eng. William da Rosa Frohlich
%---
%---	Project: Cauer Filter - High Pass
%-----------------------------------------------------

clear all
close all
clc

format long g

%filtro eliptico passa-baixas...
Amax = 1;
Amin = 50;
wp = 800;
ws = 200; 

%calculo da ordem do filtro...
[n,wn]=ellipord(wp,ws,Amax,Amin,'s');
wo = wp;

%determinacao do filtro normalizado...
[z,p,k]=ellipap(n,Amax,Amin);
%polinomio do numerador...
b = poly(z)*k;
%polinomio do denominador...
a = poly(p);

%transformacao do filtro...
[btl,atl]=lp2hp(b,a,wo);

%calculo da funcao de transferencia...
hs=tf(btl, atl)

%Verificar Requisitos
w = 0:wp/512:wp;
H = freqs(btl,atl,w);

var = (wp/512);
var1 = ceil(wp/var+1);
var2 = ceil(ws/var+1);

bode(btl,atl)

%Atenuacoes
%w = 0
mod = 20*log10(abs(H(1)))

%w = wp
mod = 20*log10(abs(H(var2)))

%w = ws
mod = 20*log10(abs(H(var1)))