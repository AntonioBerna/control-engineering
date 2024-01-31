% Esercitazione Controlli Automatici 2024

% Specifiche Controllore Digitale C(w):
% - Errore a regime nullo per riferimento a rampa
% - Overshoot <= 20%
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
Pw = d2c(Pz, "Tustin"); % non ha poli nell'origine

% Errore a regime nullo per riferimento a rampa.
% Inserisco un doppio polo nell'origine nella P(w), in questo modo
% otteniamo e_ss = 0
h = 2;
C1 = 1 / s^h;
% controlSystemDesigner(Pw, C1);

% Dopo un'analisi a tentativi il controllore che rispetta meglio
% le specifiche richieste è il seguente:
Cw = -0.25171 * (s + 0.04) * C1;
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

% Overshoot 15.1%
Wwyr = minreal(Lw / (1 + Lw));

figure;
step(Wwyr);
grid on;

% Simulazione nel piano di Tustin
t = 0:Ts:100;
ramp = t;

figure;
lsim(Wwyr, ramp, t);
grid on;

% Analisi delle performance del sistema a tempo discreto

% Se Cw era solo proporzionale avrei usato Cz = Cw;
Cz = c2d(Cw, Ts, "Tustin");
Lz = Cz * Pz;
Wzyr = minreal(Lz / (1 + Lz));

% Se passiamo da C(s) a C(z) senza passare per il piano
% equivalente di Tustin allora dobbiamo controllare
% che il sistema a ciclo chiuso sia ancora stabile
figure;
nyquist(Lz); % in questo caso il sistema a ciclo chiuso è stabile
grid on;

figure;
step(Wwyr, Wzyr);
grid on;

% Simulazione del sistema digitale
figure;
lsim(Wzyr, ramp, t);
grid on;

% In questo caso non possiamo usare un filtro Fr
% perchè il segnale di riferimento è una rampa.









