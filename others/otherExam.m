clc;
clearvars;
close all;

% Specifiche:
% - Errore a regime nullo per riferimento a rampa
% - Tempo di assestamento t_s più piccolo possibile
% - Overshoot minore del 20%
% - margine di fase maggiore di 60 gradi

s = tf("s");
P = (s - 1) / (s * (s^2 + 3 * s + 1));

% errore nullo a regime perchè P(s) è di tipo 1
h = 1;
C1 = 1 / s^h;

% Overshoot < 20%, margine di fase 84 gradi e t_s circa 60 secondi

% controlSystemDesigner(P, C1);
C2 = -0.95373 * (s + 0.1)^2;

% design del controllore completato
C = C1 * C2;
L = C * P;

figure;
rlocus(L);
grid on;

figure;
margin(L);
grid on;

% risposta al gradino
Wyr = minreal(L / (1 + L));

figure;
step(Wyr);
grid on;

% simulazione
Ts = 0.1;
t = 0:Ts:100;
ramp = t;

figure;
lsim(Wyr, ramp, t);
grid on;






