%-----------------------------------------------------
%---	Author: Eng. William da Rosa Frohlich
%---
%---	Project: Filter Chebyshev II
%-----------------------------------------------------

%Projeto de Filtros Analogicos
clear all
close all
clc

format long g

% 1 - Filtro passa-baixas
Amax = input('Valor Atenua��o M�xima (Am�x.) = ');
Amin = input('Valor Atenua��o M�nima (Am�n.) = ');
wp = input('Valor frequ�ncia wp (rad/s) = ');
ws = input('Valor frequ�ncia ws (rad/s) = ');

%Calculo da ordem do Filtro
[n,wn]=cheb2ord(wp,ws,Amax,Amin,'s');
wo = ws;

%Determina�ao do filtro normalizado
[z,p,k]=cheb2ap(n,Amin);
b = poly(z)*k;
a = poly(p);

%Transforma�ao do filtro
[bt,at]=lp2lp(b,a,wo);

% Justificativas de Resultados
h=tf(bt,at)

[H,W]=freqs(bt,at);
%figure
%bode(bt,at,W);
grid

plot(W, 20*log10(abs(H)));
figure
plot(W, 180/pi*phase(H)); 

gd = -diff(phase(H))./diff(W);
figure
plot(W(1:length(W)-1), gd);

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

% 2 - Filtro passa-altas
Amax = 1;
Amin = 50;
wp = 800;
ws = 200;

%Calculo da ordem do Filtro
[n,wn]=cheb2ord(wp,ws,Amax,Amin,'s');
wo = ws;

%Determina�ao do filtro normalizado
[z,p,k]=cheb2ap(n,Amin);
b = poly(z)*k;
a = poly(p);

%Transforma�ao do filtro
[bt1,at1]=lp2hp(b,a,wo);

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
Amax = input('Valor Atenua��o M�xima (Am�x.) = ');
Amin = input('Valor Atenua��o M�nima (Am�n.) = ');
wo = input('Valor frequ�ncia wo (rad/s) = ');
w1 = input('Valor frequ�ncia w1 (rad/s) = ');
w2 = input('Valor frequ�ncia w2 (rad/s) = ');
w3 = input('Valor frequ�ncia w3 (rad/s) = ');
w4 = input('Valor frequ�ncia w4 (rad/s) = ');
wp = [w1 w2];
ws = [w3 w4];

B = w2 - w1;

%Calculo da ordem do Filtro
[n,wn]=cheb2ord(wp,ws,Amax,Amin,'s');
B1 = B;

%Determina�ao do filtro normalizado
[z,p,k]=cheb2ap(n,Amin);
b = poly(z)*k;
a = poly(p);

B1 = ws(2)-ws(1);
wo = sqrt(ws(2)*ws(1));

%Transforma�ao do filtro
[bt2,at2]=lp2bp(b,a,wo,B1);

% Justificativas de Resultados
h=tf(bt2,at2)

[H,W]=freqs(bt2,at2);
figure
bode(bt2,at2,W);
grid

%Plotar Resposta em Frequencia
w = 0:ws(2)/512:ws(2);
H = freqs(bt2,at2,w);

%Verificar Requisitos
var = (ws(2)/512);
var1 = ceil(wp(1)/var+1);
var2 = ceil(wp(2)/var+1);
var3 = ceil(ws(1)/var+1);
var4 = ceil(ws(2)/var+1);

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
Amax = input('Valor Atenua��o M�xima (Am�x.) = ');
Amin = input('Valor Atenua��o M�nima (Am�n.) = ');
wo = input('Valor frequ�ncia wo (rad/s) = ');
w1 = input('Valor frequ�ncia w1 (rad/s) = ');
w2 = input('Valor frequ�ncia w2 (rad/s) = ');
w3 = input('Valor frequ�ncia w3 (rad/s) = ');
w4 = input('Valor frequ�ncia w4 (rad/s) = ');
wp = [w1 w2];
ws = [w3 w4];

B = w2 - w1;

%Calculo da ordem do Filtro
[n,wn]=cheb2ord(wp,ws,Amax,Amin,'s');

%Determina�ao do filtro normalizado
[z,p,k]=cheb2ap(n,Amin);
b = poly(z)*k;
a = poly(p);

B = ws(2)-ws(1);
wo = sqrt(ws(2)*ws(1));

%Transforma�ao do filtro
[bt3,at3]=lp2bs(b,a,wo,B)

% Justificativas de Resultados
h=tf(bt3,at3)

[H,W]=freqs(bt3,at3);
figure
bode(bt3,at3,W);
grid

%Plotar Resposta em Frequencia
w = 0:wp(2)/512:wp(2);
H = freqs(bt3,at3,w);

%Verificar Requisitos
var = (wp(2)/512);
var1 = ceil(wp(1)/var+1);
var2 = ceil(wp(2)/var+1);
var3 = ceil(ws(1)/var+1);
var4 = ceil(ws(2)/var+1);

%Atenuacoes
%w = 0
mod = 20*log10(abs(H(1))+eps)

%w = wp1
mod = 20*log10(abs(H(var1)))

%w = wp2
mod = 20*log10(abs(H(var2)))

%w = ws1
mod = 20*log10(abs(H(var3)))

%w = ws2
mod = 20*log10(abs(H(var4)))