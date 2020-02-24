%-----------------------------------------------------
%---	Author: Eng. William da Rosa Frohlich
%---
%---	Project: Filter Cauer I Filter
%-----------------------------------------------------


clear all           %Limpa vari�veis da mem�ria
close all           %Fecha figuras
clc                 %Limpa tela de comandos

format short        %Formata n�meros para 5 d�gitos depois da v�rgula

%Rejeita-Banda

Amax = 0.1; %Atenua��o m�xima na banda de passagem
Amin = 15;  %Atenua��o m�nima na banda de rejei��o

wo = 1095.4451; %Frequ�ncia central wo
w3 = 800;       %Frequ�ncia inferior da banda de rejei��o

w4 = 1500;      %Frequ�ncia superior da banda de rejei��o
w1 = 200;       %Frequ�ncia inferior da banda de passagem
w2 = 6000;      %Frequ�ncia superior da banda de passagem

B = w2 - w1;       %Largura de Banda

%Calculo da ordem do Filtro
[n,wn]=ellipord([w1 w2],[w3 w4],Amax,Amin,'s');  %Fun��o retorna a ordem n e a frequ�ncia de 3 dB wn

B1 = B;  %Desnormaliza��o da largura de banda para rejeita-banda

%Determina�ao do filtro normalizado
[z,p,k]=ellipap(n,Amax,Amin);

b = poly(z)*k;      %Determina o polin�mio do numerados da H(s)
a = poly(p);        %Determina o polin�mio do denumerador da H(s)

%Transforma�ao do filtro
[bt1,at1]=lp2bs(b,a,wo,B1); %Transforma o filtro passa-baixas com wp = 1 em um filtro rejeita-banda com B=B1

%Rotina para desconsiderar valores menores que 1e-2 em H(s)
for ii = 1:n+1
    if(abs(bt1(ii))<=1e-1)
        bt1(ii)=0;
        else bt1(ii) = bt1(ii);
    end
end

% Justificativas de Resultados
h=tf(bt1,at1)       %Cria a fun��o de transfer�ncia do filtro rejeita-banda com B=B1

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