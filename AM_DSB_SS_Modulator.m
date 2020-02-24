%-----------------------------------------------------
%---	Author: Eng. William da Rosa Frohlich
%---
%---	Project: AM DSB SS Modulator
%-----------------------------------------------------

close all
clear all
clc

%--- Valores Espec�ficos Por Aluno
x = 0+1+2+0+9+6+5;
y = 2*(10^(-1));

%--- Par�metros Iniciais
Ap = 1;   % Amplitude Portadora
Am = 0.5; % Amplitude Modulante
fp = x*(10^3); % Frequ�ncia Portadora
fm = y*(10^3);  % Frequ�ncia Modulante
m  = Am/Ap; % Indice de modula��o
R = 1; % Resist�ncia

%--- Vetor de tempo
t = linspace(0,1,100*fp);            

%--- Sinal Modulado
dsbsc = (Ap*Am.*cos(2*pi*fm*t).*cos(2*pi*fp*t));

%--- a) G�fico Sinal modulado
figure
plot(t,dsbsc);
title('AM DSB SC');
xlabel('Tempo');
xlim ([0 0.005]);
ylabel('AM DSB_SC(t)');

%--- b) Gr�fico do Espectro do Sinal Modulado
N = length(t);
X = fft(dsbsc)/N;

figure
eixo_x=(0:(N/2-1))*100*fp/N;
plot(eixo_x,abs(X(1:N/2)))
xlim ([2.25*(10^4) 2.35*(10^4)])

grid on
title('Espectro');
xlabel('f [Hz]');
ylabel('|AM-DSB-SC(f)|');


%--- c) Pot�ncia em cada banda lateral
Pbli = ((Ap^2)/2)*(m^2)/4
Pbls = ((Ap^2)/2)*(m^2)/4