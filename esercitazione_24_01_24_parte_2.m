% Esercitazione Controlli Automatici 2024

% Specifiche del controllore C(s):
% - Errore a regime < 10% per riferimento a rampa
% - Overshoot <= 20%
% - Tempo di assestamento t_s il più piccolo possibile
% - Design per controllare asintoticamente un
%   disturbo sull'impianto d1 = 10

clc;
clearvars;
close all;

s = tf("s");
P = 10 * (s - 1) / (s^2 + 4 * s + 8);


