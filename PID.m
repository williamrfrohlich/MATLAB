%-----------------------------------------------------
%---	Author: Eng. William da Rosa Frohlich
%---
%---	Project: PID
%-----------------------------------------------------

clear all;
clc;
clear plot;

G = zpk([],[0 -1 -5],1) %Inserir os p�los e zeros da fun��o de transfer�ncia
rltool(G)