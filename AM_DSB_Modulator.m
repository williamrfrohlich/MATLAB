%-----------------------------------------------------
%---	Author: Eng. William da Rosa Frohlich
%---
%---	Project: AM DSB Modulator
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

%--- Vetor Tempo
t = linspace(0,1,100*fp);

%--- Sinais modulados
amdsb = (Ap + Am.*cos(2*pi*fm*t)).*cos(2*pi*fp*t);
xp= cos(2*pi*fp*t);
xm = Am.*cos(2*pi*fm*t);

%--- a) Gr�fico do Sinal da Portadora
figure
plot(t,xp);
title('Sinal da Portadora');
xlabel('Tempo');
xlim ([0 0.0005]);
ylabel('AM Portadora(t)');

%--- b) Gr�fico do Sinal da Modulante
figure
plot(t,xm);
title('Sinal da Modulante');
xlabel('Tempo');
xlim ([0 0.2]);
ylabel('AM Modulante(t)');

%--- c) Gr�fico do Sinal Modulado a 50%
figure
plot(t,amdsb);
title('AM DSB 50%');
xlabel('Tempo');
xlim ([0 0.01]);
ylabel('AM DSB(t)');

%--- d) Gr�fico do espectro do sinal modulado
N = length(t);
X = fft(amdsb)/N;

figure
eixo_x=(0:(N/2-1))*100*fp/N;
plot(eixo_x,abs(X(1:N/2)))
xlim ([2.26*10^4 2.34*10^4])

grid on
title('Espectro do Sinal Modulado');
xlabel('f [Hz]');
ylabel('|AM-DSB(f)|');

%--- e) Pot�ncia na Portadora
Pp = (Ap^2)/(2*R)

%--- f) Pot�ncia em cada banda lateral
Pbli = Pp*(m^2)/4
Pbls = Pp*(m^2)/4
Pbl = Pp*(m^2)/2

%--- Verifica��o das Pot�ncias
Pt1 = Pp+Pbli+Pbls
Pt2 = Pp*(1+(m^2)/2)