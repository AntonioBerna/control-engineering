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

% Errore a regime nullo per riferimento a rampa.
% Inserisco un doppio polo nell'origine nella P(w), in questo modo
% otteniamo e_ss = 0. Inoltre con questa aggiunta applichiamo anche
% la reiezione del disturbo sull'impianto d1
h = 2;
C1 = 1 / s^h;
% controlSystemDesigner(P, C1);

% Dopo un'analisi a tentativi il controllore che rispetta meglio
% le specifiche richieste è il seguente:
C = -0.012574 * (1 + 20 * s) * C1;
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

% Overshoot 14.5%
Wyr = minreal(P * C / (1 + L));

figure;
step(Wyr);
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













