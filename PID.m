%-----------------------------------------------------
%---	Author: Eng. William da Rosa Frohlich
%---
%---	Project: PID
%-----------------------------------------------------

clear all;
clc;
clear plot;

G = zpk([],[0 -1 -5],1) %Inserir os pólos e zeros da função de transferência
rltool(G)