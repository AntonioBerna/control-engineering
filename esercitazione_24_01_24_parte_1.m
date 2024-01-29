% Esercitazione Controlli Automatici 2024

% Specifiche del controllore C(s) in presenza di un ritardo e^(-0.05 * s)
% nella P(s):
% - Errore a regime < 10% per riferimento a rampa
% - Overshoot < 20%
% - Tempo di assestamento ts il più piccolo possibile

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

% Errore a regime e_ss < 0.1 * R per riferimento a rampa.
% Poichè la Pr(s) è tipo 0, aggiungiamo un polo nell'origine per far
% diventare la Pr(s) di tipo 1, che per un riferimento a rampa
% presenta un e_ss = R / K_P * K_C, valida solo se:
% p_P + p_C - q + 1 = 0, che in questo caso è vero perchè p_P = 1 (perchè
% la Pr(s) ha un polo nell'origine), p_C = 0 e q = 2 (per la rampa).
K_P = dcgain(Pr); % |K_C| >= 1 / ((e_ss%) * |K_P|), |K_P| = 1.25
K_C = 8;

% Inizialmente il controllore è il seguente:
h = 1;
C1 = K_C / s^h;

% controlSystemDesigner(Pr, C1);

% Dopo un'analisi a tentativi il controllore che rispetta meglio
% le specifiche richieste è il seguente:
C = -0.3 / s^h;
L = C * Pr;

figure;
rlocus(L);
grid on;

figure;
nyquist(L);
grid on;

% Come si evince l'overshoot è circa 8% e il tempo
% di assestamento ts è circa 7 secondi
Wyr = minreal(L / (1 + L));

% figure;
% step(Wyr);
% grid on;

% Aggiungiamo un filtro Fr
ts = 7;
tau_fr = ts / 3;
Fr = 1 / (1 + tau_fr * s);
WyrFr = minreal(Fr * L / (1 + L));

figure;
step(Wyr, WyrFr);
grid on;

% Simulazione del sistema per riferimento a rampa
Ts = 0.1;
t = 0:Ts:100;
ramp = t;

figure;
lsim(Wyr, ramp, t);
grid on;





%%


% Pongo inizialmente il controllore
C = 1;

% controlSystemDesigner(Pr, C, H);

% Simulazione ...
L = Pr * C;
Wyr = minreal(Pr * C / (1 + L));

Ld = Pr * C * H;
Wyd2 = minreal(-Ld / (1 + Ld));

























