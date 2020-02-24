%-----------------------------------------------------
%---	Author: Eng. William da Rosa Frohlich
%---
%---	Project: Chebyshev I Filter
%-----------------------------------------------------

%Projeto de Filtros Analogicos
clear all
close all
clc

format long g

% 1 - Filtro passa-baixas
Amax = 0.3;
Amin = 30;

wp = 2*pi*500;
ws = 2*pi*1000;

%Calculo da ordem do Filtro
[n,wn]=cheb1ord(wp,ws,Amax,Amin,'s');
%wo = wp;

%Determinaçao do filtro normalizado
[z,p,k]=cheb1ap(n,Amax);
b = poly(z)*k;
a = poly(p);

%Transformaçao do filtro
[bt,at]=lp2lp(b,a,wn);

% Justificativas de Resultados
h=tf(bt,at)

[H,W]=freqs(bt,at);
figure
bode(bt,at,W);
grid

figure
dpH = diff(angle(H))./diff(W);
semilogx(W(2:end),-dpH)

%Plotar Resposta em Frequencia
w = 0:ws/512:ws;
H = freqs(bt,at,w);

%Verificar Requisitos
var = (ws/512);
var1 = ceil(wp/var+1);
var2 = ceil(ws/var+1);

%Atenuacoes
%w = 0
mod = 20*log10(abs(H(1)))

%w = wp
mod = 20*log10(abs(H(var1)))

%w = wr
mod = 20*log10(abs(H(var2)))

[sos,g]=tf2sos(bt,at)
break
% 2 - Filtro passa-altas
Amax = 0.4;
Amin = 30;

%fp = 1500;
%fs = 500;
wp = 3000; %2*pi*fp;
ws = 1000; %2*pi*fs;

%Calculo da ordem do Filtro
[n,wn]=cheb1ord(wp,ws,Amax,Amin,'s');
n

%wo = wp;

%Determinaçao do filtro normalizado
[z,p,k]=cheb1ap(n,Amax);
b = poly(z)*k;
a = poly(p);

%Transformaçao do filtro
[bt1,at1]=lp2hp(b,a,wn);

for i=1:length(bt1)
    if((bt1(i))<=1e-6) bt1(i)=0;
    end
end

for i=1:length(at1)
    if((at1(i))<=1e-6) at1(i)=0;
    end
end

% Justificativas de Resultados
h=tf(bt1,at1)

[H,W]=freqs(bt1,at1);
figure
bode(bt1,at1,W);
grid

%Plotar Resposta em Frequencia
w = 0:wp/512:wp;
H = freqs(bt1,at1,w);

%Verificar Requisitos
var = (wp/512);
var1 = ceil(wp/var+1);
var2 = ceil(ws/var+1);

%Atenuacoes
%w = 0
mod = 20*log10(abs(H(1)))

%w = wp
mod = 20*log10(abs(H(var2)))

%w = wr
mod = 20*log10(abs(H(var1)))

% 3 - Filtro passa-banda
Amax = 0.5;
Amin = 20;

w1 = 2*pi*500;
w2 = 2 *pi*1000;
w3 = 2*pi*275;
w4 = (w1*w2)/w3;

B = w2 - w1;

wo = sqrt(w1*w2);

wp = [w1 w2];
ws = [w3 w4];

%Calculo da ordem do Filtro
[n,wn]=cheb1ord(wp,ws,Amax,Amin,'s');
%B1 = B;

%Determinaçao do filtro normalizado
[z,p,k]=cheb1ap(n,Amax);
b = poly(z)*k;
a = poly(p);

%Transformaçao do filtro
[bt2,at2]=lp2bp(b,a,wo,B);

% Justificativas de Resultados
h=tf(bt2,at2)

[H,W]=freqs(bt2,at2);
figure
bode(bt2,at2,W);
grid

%Plotar Resposta em Frequencia
w = 0:w4/512:w4;
H = freqs(bt2,at2,w);

%Verificar Requisitos
var = (w4/512);
var1 = ceil(w1/var+1);
var2 = ceil(w2/var+1);
var3 = ceil(w3/var+1);
var4 = ceil(w4/var+1);

%Atenuacoes
%w = 0
mod = 20*log10(abs(H(1)))

%w = wp1
mod = 20*log10(abs(H(var1)))

%w = wp2
mod = 20*log10(abs(H(var2)))

%w = ws1
mod = 20*log10(abs(H(var3)))

%w = ws2
mod = 20*log10(abs(H(var4)))

% 4 - Filtro rejeita-banda
Amax = 0.3;
Amin = 50;

w1 = 2*pi*200;
w2 = 2 *pi*1000;
w3 = 2*pi*400;
w4 = 2*pi*500;

wp = [w1 w2];
ws = [w3 w4];

B = w2 - w1;

wo = sqrt(w1*w2);

%Calculo da ordem do Filtro
[n,wn]=cheb1ord(wp,ws,Amax,Amin,'s');

%Determinaçao do filtro normalizado
[z,p,k]=cheb1ap(n,Amax);
b = poly(z)*k;
a = poly(p);

%Transformaçao do filtro
[bt3,at3]=lp2bs(b,a,wo,B);

% Justificativas de Resultados
h=tf(bt3,at3)

[H,W]=freqs(bt3,at3);
figure
bode(bt3,at3,W);
grid

%Plotar Resposta em Frequencia
w = 0:w2/512:w2;
H = freqs(bt3,at3,w);

%Verificar Requisitos
var = (w2/512);
var1 = ceil(w1/var+1);
var2 = ceil(w2/var+1);
var3 = ceil(w3/var+1);
var4 = ceil(w4/var+1);

%Atenuacoes
%w = 0
mod = 20*log10(abs(H(1)))

%w = wp1
mod = 20*log10(abs(H(var1)))

%w = wp2
mod = 20*log10(abs(H(var2)))

%w = ws1
mod = 20*log10(abs(H(var3)))

%w = ws
mod = 20*log10(abs(H(var4)))