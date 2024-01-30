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

% Design del filtro H(s) per controllare asintoticamente un
% disturbo sull'impianto d1 = 10
H = 1; % retroazione unitaria

% figure;
% bode(H);
% grid on;

% Errore a regime e_ss < 0.1 * R per riferimento a rampa.
% Poichè P(s) è di tipo 0, aggiungiamo un polo nell'origine per far
% diventare la P(s) di tipo 1 e anche per la reiezione del disturbo
% sull'impianto d1, che per un riferimento a rampa
% presenta un e_ss = R / K_P * K_C, valida solo se:
% p_P + p_C - q + 1 = 0,  che in questo caso è vero perchè 
% p_P = 1 (perchè la P(s) ha un polo nell'origine), p_C = 0 e q = 2
% (per la rampa).
K_P = dcgain(P); % -1.25
K_C = 8; % |K_C| >= 8

h = 1;
C1 = K_C / s^h;
% controlSystemDesigner(P, C1);

% Dopo un'analisi a tentativi il controllore che rispetta meglio
% le specifiche richieste è il seguente:
C = -0.27027 / s^h;
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

% figure;
% step(Wyr);
% grid on;

% Overshoot circa 0.681% e tempo di assestamento
% ts = 4.91 secondi. Aggiungiamo un filtro Fr
ts = 4.91;
tau_fr = ts / 3;
Fr = 1 / (1 + tau_fr * s);
WyrFr = minreal(Fr * P * C / (1 + L));

figure;
step(Wyr, WyrFr);
grid on;

% Simulazione del sistema per riferimento a rampa e
% disturbo sull'impianto d1
Ts = 0.01;
t = 0:Ts:100;
d1 = 10 * ones(length(t), 1)';
ramp = t;

figure;
lsim(Wyr, ramp, t);
grid on;

Wyd1 = minreal(P / (1 + L));

figure;
lsim(Wyd1, d1, t);
grid on;













