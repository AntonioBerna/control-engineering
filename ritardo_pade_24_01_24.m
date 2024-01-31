% Esercitazione Controlli Automatici 2024

% Specifiche del controllore C(s) in presenza di un ritardo e^(-0.05 * s)
% nella P(s):
% - Errore a regime nullo per riferimento a rampa
% - Overshoot < 20%

clc;
clearvars;
close all;

s = tf("s");
P = 10 * (s - 1) / (s^2 + 4 * s + 8);

% Approssimiamo il ritardo e^(-Tr * s) con l'approssimazione di Padé
Tr = 0.05;
N = 1; % ordine dell'approssimazione di Padé
[num, den] = pade(Tr, N);
Pa = tf(num, den);
Pr = P * Pa; % Nuovo plant P(s) con il ritardo approssimato

% figure;
% bode(Pr, P * exp(-Tr * s));
% grid on;

% Errore a regime nullo per riferimento a rampa.
% Inserisco un doppio polo nell'origine nella Pr(s), in questo modo
% otteniamo e_ss = 0
h = 2;
C1 = 1 / s^h;
% controlSystemDesigner(Pr, C1);

% Dopo un'analisi a tentativi il controllore che rispetta meglio
% le specifiche richieste è il seguente:
C = -2.1952 * ((s + 0.1) * (s + 1)) / ((s + 10)) * C1;
L = Pr * C;
Wyr = minreal(L / (1 + L));

% Overshoot 19.2%
figure;
step(Wyr);
grid on;

Ts = 0.1;
t = 0:Ts:100;
ramp = t;

figure;
lsim(Wyr, ramp, t);
grid on;

% In questo caso non possiamo usare un filtro Fr
% perchè il segnale di riferimento è una rampa.























