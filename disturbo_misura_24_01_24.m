% Esercitazione Controlli Automatici 2024

% Specifiche del controllore C(s):
% - Errore a regime nullo per riferimento a rampa
% - Overshoot <= 20%
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

% Errore a regime nullo per riferimento a rampa.
% Inserisco un doppio polo nell'origine nella Pr(s), in questo modo
% otteniamo e_ss = 0
h = 2;
C1 = 1 / s^h;
% controlSystemDesigner(P, C1, H);

% Dopo un'analisi a tentativi il controllore che rispetta meglio
% le specifiche richieste è il seguente:
C = -0.2714 * (s + 0.05) * C1;
L = C * P * H;
Wyr = minreal(P * C / (1 + L));

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

% Overshoot 15.2%
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

% In questo caso non possiamo usare un filtro Fr
% perchè il segnale di riferimento è una rampa.

















