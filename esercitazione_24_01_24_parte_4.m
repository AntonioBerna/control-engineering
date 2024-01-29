% Esercitazione Controlli Automatici 2024

% Specifiche del controllore C(s):
% - Errore a regime < 10% per riferimento a rampa
% - Overshoot <= 20%
% - Tempo di assestamento t_s il più piccolo possibile
% - Design per controllare asitoticamente un disturbo
%   di misura d2 = 10 * sin(2 * pi * 50)

clc;
clearvars;
close all;

s = tf("s");
P = 10 * (s - 1) / (s^2 + 4 * s + 8);

% da capire: chiedere a federico come ha svolto questo caso
H = ((s / (2 * pi * 50))^2 + 1) / (1 + 0.1 * s)^2;


















