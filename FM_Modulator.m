%-----------------------------------------------------
%---	Author: Eng. William da Rosa Frohlich
%---
%---	Project: FM Modulator
%-----------------------------------------------------

close all
clear all
clc

%--- Valores Espec�ficos Por Aluno
x = 0+1+2+0+9+6+5;

%--- Vetor Tempo
t = linspace(0,1,10*x*100); % Vetor de 0 a 1, com 23000 pontos

%--- Gr�ficos Sinal Modulado

%---            Modula��o com �ndice 0.5            ---
Ap = 2;   % Amplitude Portadora
Am = 0.5; % Amplitude Modulante
fp = x*100; % Frequ�ncia Portadora
fm = x*10;  % Frequ�ncia Modulante
f_delta = fp*0.1; % Sensibilidade
beta = Am*f_delta/fm % �ndice de Modula��o

Xfm = Ap.*cos(2*pi*fp*t+beta.*sin(2*pi*fm*t)); % Fun��o do sinal modulado em frequencia

figure
subplot (2,1,1)
plot(t,Xfm);
title('Sinal FM - Beta = 0,5');
xlabel('Tempo');
xlim ([0 0.01]);
ylabel('Xfm (t)');

%---            Modula��o com �ndice 1              ---
Ap = 2.5;   % Amplitude Portadora
Am = 1; % Amplitude Modulante
fp = x*100; % Frequ�ncia Portadora
fm = x*10;  % Frequ�ncia Modulante
f_delta = fp*0.1; % Sensibilidade
beta = Am*f_delta/fm % �ndice de Modula��o

Xfm = Ap.*cos(2*pi*fp*t+beta.*sin(2*pi*fm*t)); % Fun��o do sinal modulado em frequencia

subplot (2,1,2)
plot(t,Xfm);
title('Sinal FM - Beta = 1');
xlabel('Tempo');
xlim ([0 0.01]);
ylabel('Xfm (t)');


%---            Modula��o com �ndice 1,5            ---
Ap = 3;   % Amplitude Portadora
Am = 1.5; % Amplitude Modulante
fp = x*100; % Frequ�ncia Portadora
fm = x*10;  % Frequ�ncia Modulante
f_delta = fp*0.1; % Sensibilidade
beta = Am*f_delta/fm % �ndice de Modula��o

Xfm = Ap.*cos(2*pi*fp*t+beta.*sin(2*pi*fm*t)); % Fun��o do sinal modulado em frequencia

figure
subplot (2,1,1)
plot(t,Xfm);
title('Sinal FM - Beta = 1,5');
xlabel('Tempo');
xlim ([0 0.01]);
ylabel('Xfm (t)');

%---            Modula��o com �ndice 2           ---
Ap = 4; % Amplitude Portadora
Am = 2; % Amplitude Modulante
fp = x*100; % Frequ�ncia Portadora
fm = x*10;  % Frequ�ncia Modulante
f_delta = fp*0.1; % Sensibilidade
beta = Am*f_delta/fm % �ndice de Modula��o

Xfm = Ap.*cos(2*pi*fp*t+beta.*sin(2*pi*fm*t)); % Fun��o do sinal modulado em frequencia

subplot (2,1,2)
plot(t,Xfm);
title('Sinal FM - Beta = 2');
xlabel('Tempo');
xlim ([0 0.01]);
ylabel('Xfm (t)');


%---			Gr�ficos Espectro			---

Ap = 2;   % Amplitude Portadora
Am = 0.5; % Amplitude Modulante
fp = x*100; % Frequ�ncia Portadora
fm = x*10;  % Frequ�ncia Modulante
f_delta = fp*0.1; % Sensibilidade
beta = Am*f_delta/fm % �ndice de Modula��o

Xfm = Ap.*cos(2*pi*fp*t+beta.*sin(2*pi*fm*t)); % Fun��o do sinal modulado em frequencia

N = length(t);
X = fft(Xfm)/N;

figure
subplot (2,1,1)
eixo_x=(0:(N/2-1))*100*fp/N;
plot(eixo_x,2*abs(X(1:N/2)))
xlim ([1.5*10^4 3.1*10^4])

grid on
title('Espectro FM - Beta = 0,5');
xlabel('f [Hz]');
ylabel('|FM(f)|');

%---            Modula��o com �ndice 1            ---
Ap = 2.5;   % Amplitude Portadora
Am = 1; % Amplitude Modulante
fp = x*100; % Frequ�ncia Portadora
fm = x*10;  % Frequ�ncia Modulante
f_delta = fp*0.1; % Sensibilidade
beta = Am*f_delta/fm % �ndice de Modula��o

Xfm = Ap.*cos(2*pi*fp*t+beta.*sin(2*pi*fm*t)); % Fun��o do sinal modulado em frequencia

N = length(t);
X = fft(Xfm)/N;

subplot (2,1,2)
eixo_x=(0:(N/2-1))*100*fp/N;
plot(eixo_x,2*abs(X(1:N/2)))
xlim ([1.5*10^4 3.1*10^4])

grid on
title('Espectro FM - Beta = 1');
xlabel('f [Hz]');
ylabel('|FM(f)|');

%---            Modula��o com �ndice 1,5             ---
Ap = 3;   % Amplitude Portadora
Am = 1.5; % Amplitude Modulante
fp = x*100; % Frequ�ncia Portadora
fm = x*10;  % Frequ�ncia Modulante
f_delta = fp*0.1; % Sensibilidade
beta = Am*f_delta/fm % �ndice de Modula��o

Xfm = Ap.*cos(2*pi*fp*t+beta.*sin(2*pi*fm*t)); % Fun��o do sinal modulado em frequencia

N = length(t);
X = fft(Xfm)/N;

figure
subplot (2,1,1)
eixo_x=(0:(N/2-1))*100*fp/N;
plot(eixo_x,2*abs(X(1:N/2)))
xlim ([0.9*10^4 3.7*10^4])

grid on
title('Espectro FM - Beta = 1,5');
xlabel('f [Hz]');
ylabel('|FM(f)|');

%---            Modula��o com �ndice 2            ---
Ap = 4;   % Amplitude Portadora
Am = 2; % Amplitude Modulante
fp = x*100; % Frequ�ncia Portadora
fm = x*10;  % Frequ�ncia Modulante
f_delta = fp*0.1; % Sensibilidade
beta = Am*f_delta/fm; % �ndice de Modula��o

Xfm = Ap.*cos(2*pi*fp*t+beta.*sin(2*pi*fm*t)); % Fun��o do sinal modulado em frequencia

N = length(t);
X = fft(Xfm)/N;

subplot (2,1,2)
eixo_x=(0:(N/2-1))*100*fp/N;
plot(eixo_x,2*abs(X(1:N/2)))
xlim ([0.9*10^4 3.7*10^4])

grid on
title('Espectro FM - Beta = 2');
xlabel('f [Hz]');
ylabel('|FM(f)|');