% Controlli Automatici - Esame 22-02-2022

% Specifiche del controllore C:
% - Errore nullo per riferimento a rampa
% - Overshoot più piccolo possibile
% - Tempo di assestamento t_s più piccolo possibile

clc;
clearvars;
close all;

s = tf("s");
P = -(s + 5) / (s * (s^2 + 4*s + 2));

% Utilizzo i diagrammi di Bode, il luogo delle radici e il diagramma di
% Nyquist per avere informazioni sul plant P

% figure;
% margin(P);
% grid on;
% 
% figure;
% rlocus(P);
% 
% figure;
% nyquist(P);

% Soluzione 2: PID
% ...











