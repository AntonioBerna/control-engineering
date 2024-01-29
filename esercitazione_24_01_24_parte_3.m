% Esercitazione Controlli Automatici 2024

% Specifiche Controllore Digitale C(w):
% - Errore a regime < 10% per riferimento a rampa
% - Overshoot <= 20%
% - Tempo di assestamento t_s il più piccolo possibile
% - Analisi delle performance del sistema a tempo discreto C(z)

clc;
clearvars;
close all;

s = tf("s");
P = 10 * (s - 1) / (s^2 + 4 * s + 8);

% Presenza del distrubo di misura d2
Ts = 0.01;
t = 0:Ts:100;
A = 10;
f = 50;
w = 2 * pi * f;
d2 = A * sin(w * t);

% Design del filtro H per la reiezione del disturbo d2
% mettendo un polo p una decade prima della pulsazione w
p = w / 10;
tau = 1 / p;
H = 1 / (1 + tau * s);







