%-----------------------------------------------------
%---	Author: Eng. William da Rosa Frohlich
%---
%---	Project: Cauer II Filter
%-----------------------------------------------------

clear all
close all
clc

format long g

%filtro eliptico passa-baixas...
Amax = 0.5;
Amin = 65;
wp = 1000;
ws = 2000; 

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
[bt,at]=lp2lp(b,a,wo);

%calculo da funcao de transferencia...
hs=tf(bt, at)

%Verificar Requisitos
w = 0:ws/512:ws;
H = freqs(bt,at,w);

var = (ws/512);
var1 = ceil(wp/var+1);
var2 = ceil(ws/var+1);

bode(bt,at)

%Atenuacoes
%w = 0
mod = 20*log10(abs(H(1)))

%w = wp
mod = 20*log10(abs(H(var1)))

%w = ws
mod = 20*log10(abs(H(var2)))