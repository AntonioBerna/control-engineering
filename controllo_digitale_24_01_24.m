% Esercitazione Controlli Automatici 2024

% Specifiche Controllore Digitale C(w):
% - Errore a regime < 10% per riferimento a rampa
% - Overshoot <= 20%
% - Tempo di assestamento t_s il più piccolo possibile
% - Analisi delle performance del sistema a tempo discreto C(z)
% - Definire il tempo di campionamento e la banda passante

clc;
clearvars;
close all;

s = tf("s");
P = 10 * (s - 1) / (s^2 + 4 * s + 8);

% Ts <= (2 * pi / w_b) / 10
% per w_b = 5 rad/s (banda passante)
Ts = 0.1; % tempo di campionamento

Pz = c2d(P, Ts, "zoh");
Pw = d2c(Pz, "Tustin") % nuova P(s)

% Errore a regime e_ss < 0.1 * R
K_Pw = dcgain(Pw); % => |K_C| >= 1 / ((e_ss%) * |K_Pw|), |K_Pw| = 1.25
K_C = 8;

h = 1;
C1 = K_C / s^h;

% controlSystemDesigner(Pw, C1);

% Dopo un'analisi a tentativi il controllore che rispetta meglio
% le specifiche richieste è il seguente:
Cw = -0.27592 / s^h;
Lw = Cw * Pw;

% figure;
% margin(Lw);
% grid on;
% 
% figure;
% rlocus(Lw);
% grid on;
% 
% figure;
% nyquist(Lw);
% grid on;

% Come si evince l'overshoot è circa 3% e il tempo
% di assestamento ts è circa 6.76 secondi

% Wwyr = minreal(Lw / (1 + Lw));

% Aggiungiamo un filtro Fr
ts = 6.67;
tau_fr = ts / 3;
Fr = 1 / (1 + tau_fr * s);

Wwyr = minreal(Fr * Lw / (1 + Lw));

% figure;
% step(Wwyr);
% grid on;

% Analisi delle performance del sistema a tempo discreto
Cz = c2d(Cw, Ts, "Tustin");

Frz = c2d(Fr, Ts, "Tustin");
Lz = Cz * Pz;
Wzyr = minreal(Frz * Lz / (1 + Lz));

% Se passiamo da C(s) a C(z) senza passare per il piano
% equivalente di Tustin allora dobbiamo controllare
% che il sistema a ciclo chiuso sia ancora stabile
figure;
nyquist(Lz); % in questo caso il sistema è stabile
grid on;

figure;
step(Wwyr, Wzyr);
grid on;

% Simulazione dei sistemi nel piano di Tustin e nel caso digitale
% per riferimento a rampa
t = 0:Ts:100;
ramp = t;

figure;
lsim(Wwyr, ramp, t);
grid on;

figure;
lsim(Wzyr, ramp, t);
grid on;











