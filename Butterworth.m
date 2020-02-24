%-----------------------------------------------------
%---	Author: Eng. William da Rosa Frohlich
%---
%---	Project: Butterworth Filter
%-----------------------------------------------------

clear all           %Limpa variáveis da memória
close all           %Fecha figuras
clc                 %Limpa tela de comandos

format long g        %Formata números para 5 dígitos depois da vírgula

%Passa-Baixas

Amax = 1; %input('Amax = ');        %Atenuação máxima na banda de passagem
Amin = 20; %input('Amin = ');          %Atenuação mínima na banda de rejeição

fp = 1000;
fs = 4500;

wp = 2*pi*fp;           %Frequência limite da banda de passagem
ws = 2*pi*fs;           %Frequência limite da banda de rejeição

%Calculo de Epslon
E = sqrt(10^(0.1*Amax)-1);

%Calculo da ordem do Filtro
[n,wn]=buttord(wp,ws,Amax,Amin,'s');    %Função retorna a ordem n e a frequência de 3 dB wn

wo = wp/E^(1/n);    %Desnormalização da frequência para passa-baixas wp = wo

%Determinaçao do filtro normalizado
[z,p,k]=buttap(n);  %Determina os zeros (z), pólos (p) e ganho (k) de um filtro de ordem n
b = poly(z)*k;      %Determina o polinômio do numerados da H(s)
a = poly(p);        %Determina o polinômio do denumerador da H(s)

%Transformaçao do filtro
[bt1,at1]=lp2lp(b,a,wo);    %Transforma o filtro passa-baixas com wp = 1 em um filtro passa-baixas com wp=wo

% Justificativas de Resultados
h=tf(bt1,at1)       %Cria a função de transferência do filtro passa-baixas com wp=wo 
[sos,g] = tf2sos(bt1,at1)

[H,W]=freqs(bt1,at1);   %Calcula a resposta em frequência (H) para cada frequência (W)
figure                  %Abre janela de figura
bode(bt1,at1,W);        %Gera o gráfico de módulo e fase da H(s)

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

Amax = 1;        %Atenuação máxima na banda de passagem
Amin = 20;          %Atenuação mínima na banda de rejeição

%fp = 15000;
%fs = 1500;

wp = 1000*pi*2;  %2*pi*fp;          %Frequência limite da banda de rejeição
ws = 4500*pi*2;  %2*pi*fs;          %Frequência limite da banda de passagem

%Calculo de Epslon
E = sqrt(10^(0.1*Amax)-1);

%Calculo da ordem do Filtro
[n,wn]=buttord(wp,ws,Amax,Amin,'s');    %Função retorna a ordem n e a frequência de 3 dB wn

wo = wp*(E^(1/n));  %Desnormalização da frequência para passa-altas wp = wo

%Determinaçao do filtro normalizado
[z,p,k]=buttap(n);  %Determina os zeros (z), pólos (p) e ganho (k) de um filtro de ordem n
b = poly(z)*k;      %Determina o polinômio do numerados da H(s)
a = poly(p);        %Determina o polinômio do denumerador da H(s)

%Transformaçao do filtro
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
h=tf(bt1,at1)       %Cria a função de transferência do filtro passa-altas com wp=wo
[sos,g] = tf2sos(bt1,at1)

[H,W]=freqs(bt1,at1);   %Calcula a resposta em frequência (H) para cada frequência (W)
figure                  %Abre janela de figura
bode(bt1,at1,W);        %Gera o gráfico de módulo e fase da H(s)

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

Amax = 0.1; %Atenuação máxima na banda de passagem
Amin = 15;  %Atenuação mínima na banda de rejeição

wo = 2*pi*1000; %Frequência central wo
w3 = 2*pi*200;  %Frequência inferior da banda de rejeição
B = 2*pi*450;   %Largura de Banda

w4 = wo^2/w3;   %Frequência superior da banda de rejeição
w1 = 5026.5482; %Frequência inferior da banda de passagem
w2 = 7853.9816; %Frequência superior da banda de passagem

%Calculo de Epslon
E = sqrt(10^(0.1*Amax)-1);

%Calculo da ordem do Filtro
[n,wn]=buttord([w1 w2],[w3 w4],Amax,Amin,'s');  %Função retorna a ordem n e a frequência de 3 dB wn

B1 = B/(E^(1/n));   %Desnormalização da largura de banda para passa-banda

%Determinaçao do filtro normalizado
[z,p,k]=buttap(n);  %Determina os zeros (z), pólos (p) e ganho (k) de um filtro de ordem n
b = poly(z)*k;      %Determina o polinômio do numerados da H(s)
a = poly(p);        %Determina o polinômio do denumerador da H(s)

%Transformaçao do filtro
[bt1,at1]=lp2bp(b,a,wo,B1); %Transforma o filtro passa-baixas com wp = 1 em um filtro passa-banda com B=B1

%Rotina para desconsiderar valores menores que 1e-2 em H(s)
for ii = 1:n+1
    if(abs(bt1(ii))<=1e-02)
        bt1(ii)=0;
        else bt1(ii) = bt1(ii);
    end
end

% Justificativas de Resultados
h=tf(bt1,at1)       %Cria a função de transferência do filtro passa-banda com B=B1
[sos,g] = tf2sos(bt1,at1)

[H,W]=freqs(bt1,at1);   %Calcula a resposta em frequência (H) para cada frequência (W)
figure                  %Abre janela de figura
bode(bt1,at1,W);        %Gera o gráfico de módulo e fase da H(s)

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

Amax = 0.1; %Atenuação máxima na banda de passagem
Amin = 15;  %Atenuação mínima na banda de rejeição

wo = 1095.4451; %Frequência central wo
w3 = 800;       %Frequência inferior da banda de rejeição
B = 5800;       %Largura de Banda

w4 = 1500;      %Frequência superior da banda de rejeição
w1 = 200;       %Frequência inferior da banda de passagem
w2 = 6000;      %Frequência superior da banda de passagem

%Calculo de Epslon
E = sqrt(10^(0.1*Amax)-1);

%Calculo da ordem do Filtro
[n,wn]=buttord([w1 w2],[w3 w4],Amax,Amin,'s');  %Função retorna a ordem n e a frequência de 3 dB wn

B1 = B*E^(1/n);  %Desnormalização da largura de banda para rejeita-banda

%Determinaçao do filtro normalizado
[z,p,k]=buttap(n);  %Determina os zeros (z), pólos (p) e ganho (k) de um filtro de ordem n
b = poly(z)*k;      %Determina o polinômio do numerados da H(s)
a = poly(p);        %Determina o polinômio do denumerador da H(s)

%Transformaçao do filtro
[bt1,at1]=lp2bs(b,a,wo,B1); %Transforma o filtro passa-baixas com wp = 1 em um filtro rejeita-banda com B=B1

%Rotina para desconsiderar valores menores que 1e-2 em H(s)
for ii = 1:n+1
    if(abs(bt1(ii))<=1e-02)
        bt1(ii)=0;
        else bt1(ii) = bt1(ii);
    end
end

% Justificativas de Resultados
h=tf(bt1,at1)       %Cria a função de transferência do filtro rejeita-banda com B=B1
[sos,g] = tf2sos(bt1,at1)

[H,W]=freqs(bt1,at1);   %Calcula a resposta em frequência (H) para cada frequência (W)
figure                  %Abre janela de figura
bode(bt1,at1,W);        %Gera o gráfico de módulo e fase da H(s)

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