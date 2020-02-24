%-----------------------------------------------------
%---	Author: Eng. William da Rosa Frohlich
%---
%---	Project: Butterworth Filter
%-----------------------------------------------------

clear all           %Limpa vari�veis da mem�ria
close all           %Fecha figuras
clc                 %Limpa tela de comandos

format long g        %Formata n�meros para 5 d�gitos depois da v�rgula

%Passa-Baixas

Amax = 1; %input('Amax = ');        %Atenua��o m�xima na banda de passagem
Amin = 20; %input('Amin = ');          %Atenua��o m�nima na banda de rejei��o

fp = 1000;
fs = 4500;

wp = 2*pi*fp;           %Frequ�ncia limite da banda de passagem
ws = 2*pi*fs;           %Frequ�ncia limite da banda de rejei��o

%Calculo de Epslon
E = sqrt(10^(0.1*Amax)-1);

%Calculo da ordem do Filtro
[n,wn]=buttord(wp,ws,Amax,Amin,'s');    %Fun��o retorna a ordem n e a frequ�ncia de 3 dB wn

wo = wp/E^(1/n);    %Desnormaliza��o da frequ�ncia para passa-baixas wp = wo

%Determina�ao do filtro normalizado
[z,p,k]=buttap(n);  %Determina os zeros (z), p�los (p) e ganho (k) de um filtro de ordem n
b = poly(z)*k;      %Determina o polin�mio do numerados da H(s)
a = poly(p);        %Determina o polin�mio do denumerador da H(s)

%Transforma�ao do filtro
[bt1,at1]=lp2lp(b,a,wo);    %Transforma o filtro passa-baixas com wp = 1 em um filtro passa-baixas com wp=wo

% Justificativas de Resultados
h=tf(bt1,at1)       %Cria a fun��o de transfer�ncia do filtro passa-baixas com wp=wo 
[sos,g] = tf2sos(bt1,at1)

[H,W]=freqs(bt1,at1);   %Calcula a resposta em frequ�ncia (H) para cada frequ�ncia (W)
figure                  %Abre janela de figura
bode(bt1,at1,W);        %Gera o gr�fico de m�dulo e fase da H(s)

figure
dpH = diff(angle(H))./diff(W);
semilogx(W(2:end),-dpH)

%Verificar Requisitos
w = 0:ws/512:ws;
H = freqs(bt1,at1,w);

var = (ws/512);
var1 = ceil(wp/var+1);
var2 = ceil(ws/var+1);

%Verificar Requisitos
w = 0:ws/512:2*ws;
H = freqs(bt1,at1,w);

var3 = ceil(2*ws/var+1);

%Atenuacoes
%w = 0
mod = 20*log10(abs(H(1)))

%w = wp
mod = 20*log10(abs(H(var1)))

%w = ws
mod = 20*log10(abs(H(var2)))

%w = 2*ws
mod = 20*log10(abs(H(var3)))

[sos,g]=tf2sos(bt1,at1)
break
%Passa-Altas

Amax = 1;        %Atenua��o m�xima na banda de passagem
Amin = 20;          %Atenua��o m�nima na banda de rejei��o

%fp = 15000;
%fs = 1500;

wp = 1000*pi*2;  %2*pi*fp;          %Frequ�ncia limite da banda de rejei��o
ws = 4500*pi*2;  %2*pi*fs;          %Frequ�ncia limite da banda de passagem

%Calculo de Epslon
E = sqrt(10^(0.1*Amax)-1);

%Calculo da ordem do Filtro
[n,wn]=buttord(wp,ws,Amax,Amin,'s');    %Fun��o retorna a ordem n e a frequ�ncia de 3 dB wn

wo = wp*(E^(1/n));  %Desnormaliza��o da frequ�ncia para passa-altas wp = wo

%Determina�ao do filtro normalizado
[z,p,k]=buttap(n);  %Determina os zeros (z), p�los (p) e ganho (k) de um filtro de ordem n
b = poly(z)*k;      %Determina o polin�mio do numerados da H(s)
a = poly(p);        %Determina o polin�mio do denumerador da H(s)

%Transforma�ao do filtro
[bt1,at1]=lp2hp(b,a,wo);    %Transforma o filtro passa-baixas com wp = 1 em um filtro passa-altas com wp=wo

for i=1:length(bt1)
    if(abs(bt1(i))<1e-7) bt1(i)=0;
    end
end

for i=1:length(at1)
    if(abs(at1(i))<1e-7) at1(i)=0;
    end
end

% Justificativas de Resultados
h=tf(bt1,at1)       %Cria a fun��o de transfer�ncia do filtro passa-altas com wp=wo
[sos,g] = tf2sos(bt1,at1)

[H,W]=freqs(bt1,at1);   %Calcula a resposta em frequ�ncia (H) para cada frequ�ncia (W)
figure                  %Abre janela de figura
bode(bt1,at1,W);        %Gera o gr�fico de m�dulo e fase da H(s)

%Verificar Requisitos

w = 0:wp/512:wp;
H = freqs(bt1,at1,w);

var = (wp/512);
var1 = ceil(wp/var+1);
var2 = ceil(ws/var+1);

%Atenuacoes
%w = 0
mod = 20*log10(abs(H(1)))

%w = wp
mod = 20*log10(abs(H(var2)))

%w = ws
mod = 20*log10(abs(H(var1)))

%Passa-Banda

Amax = 0.1; %Atenua��o m�xima na banda de passagem
Amin = 15;  %Atenua��o m�nima na banda de rejei��o

wo = 2*pi*1000; %Frequ�ncia central wo
w3 = 2*pi*200;  %Frequ�ncia inferior da banda de rejei��o
B = 2*pi*450;   %Largura de Banda

w4 = wo^2/w3;   %Frequ�ncia superior da banda de rejei��o
w1 = 5026.5482; %Frequ�ncia inferior da banda de passagem
w2 = 7853.9816; %Frequ�ncia superior da banda de passagem

%Calculo de Epslon
E = sqrt(10^(0.1*Amax)-1);

%Calculo da ordem do Filtro
[n,wn]=buttord([w1 w2],[w3 w4],Amax,Amin,'s');  %Fun��o retorna a ordem n e a frequ�ncia de 3 dB wn

B1 = B/(E^(1/n));   %Desnormaliza��o da largura de banda para passa-banda

%Determina�ao do filtro normalizado
[z,p,k]=buttap(n);  %Determina os zeros (z), p�los (p) e ganho (k) de um filtro de ordem n
b = poly(z)*k;      %Determina o polin�mio do numerados da H(s)
a = poly(p);        %Determina o polin�mio do denumerador da H(s)

%Transforma�ao do filtro
[bt1,at1]=lp2bp(b,a,wo,B1); %Transforma o filtro passa-baixas com wp = 1 em um filtro passa-banda com B=B1

%Rotina para desconsiderar valores menores que 1e-2 em H(s)
for ii = 1:n+1
    if(abs(bt1(ii))<=1e-02)
        bt1(ii)=0;
        else bt1(ii) = bt1(ii);
    end
end

% Justificativas de Resultados
h=tf(bt1,at1)       %Cria a fun��o de transfer�ncia do filtro passa-banda com B=B1
[sos,g] = tf2sos(bt1,at1)

[H,W]=freqs(bt1,at1);   %Calcula a resposta em frequ�ncia (H) para cada frequ�ncia (W)
figure                  %Abre janela de figura
bode(bt1,at1,W);        %Gera o gr�fico de m�dulo e fase da H(s)

%Verificar Requisitos

w = 0:w4/512:w4;
H = freqs(bt1,at1,w);

var = (w4/512);
var1 = ceil(w1/var+1);
var2 = ceil(w2/var+1);
var3 = ceil(w3/var+1);
var4 = ceil(w4/var+1);

%Atenuacoes
%w = 0
mod = 20*log10(abs(H(1)))

%w = w1
mod = 20*log10(abs(H(var1)))

%w = w2
mod = 20*log10(abs(H(var2)))

%w = w3
mod = 20*log10(abs(H(var3)))

%w = w4
mod = 20*log10(abs(H(var4)))

%Rejeita-Banda

Amax = 0.1; %Atenua��o m�xima na banda de passagem
Amin = 15;  %Atenua��o m�nima na banda de rejei��o

wo = 1095.4451; %Frequ�ncia central wo
w3 = 800;       %Frequ�ncia inferior da banda de rejei��o
B = 5800;       %Largura de Banda

w4 = 1500;      %Frequ�ncia superior da banda de rejei��o
w1 = 200;       %Frequ�ncia inferior da banda de passagem
w2 = 6000;      %Frequ�ncia superior da banda de passagem

%Calculo de Epslon
E = sqrt(10^(0.1*Amax)-1);

%Calculo da ordem do Filtro
[n,wn]=buttord([w1 w2],[w3 w4],Amax,Amin,'s');  %Fun��o retorna a ordem n e a frequ�ncia de 3 dB wn

B1 = B*E^(1/n);  %Desnormaliza��o da largura de banda para rejeita-banda

%Determina�ao do filtro normalizado
[z,p,k]=buttap(n);  %Determina os zeros (z), p�los (p) e ganho (k) de um filtro de ordem n
b = poly(z)*k;      %Determina o polin�mio do numerados da H(s)
a = poly(p);        %Determina o polin�mio do denumerador da H(s)

%Transforma�ao do filtro
[bt1,at1]=lp2bs(b,a,wo,B1); %Transforma o filtro passa-baixas com wp = 1 em um filtro rejeita-banda com B=B1

%Rotina para desconsiderar valores menores que 1e-2 em H(s)
for ii = 1:n+1
    if(abs(bt1(ii))<=1e-02)
        bt1(ii)=0;
        else bt1(ii) = bt1(ii);
    end
end

% Justificativas de Resultados
h=tf(bt1,at1)       %Cria a fun��o de transfer�ncia do filtro rejeita-banda com B=B1
[sos,g] = tf2sos(bt1,at1)

[H,W]=freqs(bt1,at1);   %Calcula a resposta em frequ�ncia (H) para cada frequ�ncia (W)
figure                  %Abre janela de figura
bode(bt1,at1,W);        %Gera o gr�fico de m�dulo e fase da H(s)

%Verificar Requisitos

w = 0:w2/512:w2;
H = freqs(bt1,at1,w);

var = (w2/512);
var1 = ceil(w1/var+1);
var2 = ceil(w2/var+1);
var3 = ceil(w3/var+1);
var4 = ceil(w4/var+1);

%Atenuacoes
%w = 0
mod = 20*log10(abs(H(1)))

%w = w1
mod = 20*log10(abs(H(var1)))

%w = w2
mod = 20*log10(abs(H(var2)))

%w = w3
mod = 20*log10(abs(H(var3)))

%w = w4
mod = 20*log10(abs(H(var4)))