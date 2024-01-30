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

% Design del filtro H per controllare asintoticamente il disturbo
% di misura d2 = 10 * sin(2 * pi * 50)
a = 2;
zeta = 0;
f = 50;
Wn = 2 * pi * f;
first_pole = (a * Wn) / (s + (a * Wn));
second_pole = (Wn / a) / (s + (Wn / a));
H = (s^2 + 2 * zeta * Wn * s + Wn^2) / (Wn^2) * first_pole * second_pole;

% figure;
% bode(H);
% grid on;

% Errore a regime e_ss < 0.1 * R per riferimento a rampa.
% Poichè P(s) è di tipo 0, aggiungiamo un polo nell'origine per far
% diventare la P(s) di tipo 1, che per un riferimento a rampa
% presenta un e_ss = R / K_H * K_P * K_C, valida solo se:
% p_H + p_P + p_C - q + 1 = 0,  che in questo caso è vero perchè p_H = 0, 
% p_P = 1 (perchè la P(s) ha un polo nell'origine), p_C = 0 e q = 2
% (per la rampa).
K_H = dcgain(H); % 1
K_P = dcgain(P); % -1.25

% |K_C| >= 1 / ((e_ss%) * |K_P| * |K_H|), |K_P| = 1.25, |K_H| = 1
K_C = 8;

% Inizialmente il controllore è il seguente:
h = 1;
C1 = K_C / s^h;

% controlSystemDesigner(P, C1, H);

% Dopo un'analisi a tentativi il controllore che rispetta meglio
% le specifiche richieste è il seguente:
C = -0.26753 / s^h;
L = C * P * H;

% figure;
% margin(L);
% grid on;
% 
% figure;
% rlocus(L);
% grid on;
% 
% figure;
% nyquist(L);
% grid on;

% Risposta al gradino
Wyr = minreal(P * C / (1 + L));

figure;
step(Wyr);
grid on;

% Simulazione del sistema per riferimento a rampa e
% disturbo di misura d2
Ts = 0.01;
t = 0:Ts:100;
A = 10;
f = 50;
w = 2 * pi * f;
d2 = A * sin(w * t) + 0.02 * randn(length(t), 1)';
ramp = t;

figure;
lsim(Wyr, ramp, t);
grid on;

Wyd2 = minreal(-L / (1 + L));

figure;
lsim(Wyd2, d2, t);
grid on;



















