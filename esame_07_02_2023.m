% Controllore Digitale C(z) con le seguenti specifiche:
% - e_ss < 0.1 * R per ingressi a rampa R * t * delta_{-1}(t)
% - overshoot < 20%
% - definire il tempo di campionamento

clc;
clearvars;
close all;

s = tf("s");
P = (s - 1) / (s * (s + 10));

% Ts <= (2 * pi / w_b) / 10
% per w_b = 5 rad/s (banda passante)
Ts = 0.1; % tempo di campionamento

Pz = c2d(P, Ts, "zoh");
Pw = d2c(Pz, "Tustin")

% Errore a regime e_ss < 0.1 * R
K_Pw = dcgain(Pw) % => |K_C| >= 1 / ((e_ss%) * |K_Pw|)
K_C = 1;

C1 = K_C;
% controlSystemDesigner(Pw, C1);

% Design del controllore C(w) terminato
Cw = K_C * -5.4288;
Lw = Cw * Pw;

ts = 3.33;
tau_fr = ts / 3;
Fr = 1 / (1 + tau_fr * s);

Wwyr = minreal(Fr * Lw / (1 + Lw));

% Analisi delle performance del sistema a tempo discreto

% c2d(Cw, Ts, "Tustin"); => non posso usarlo
% perchè il controllore C(w) è proporzionale
Cz = Cw;

Frz = c2d(Fr, Ts, "Tustin");
Lz = Cz * Pz;
Wzyr = minreal(Lz / (1 + Lz));

% Se passiamo da C(s) a C(z) senza passare per il piano
% equivalente di Tustin allora dobbiamo controllare
% che il sistema a ciclo chiuso sia ancora stabile
figure;
nyquist(Lz); % in questo caso il sistema è stabile
grid on;

figure;
step(Wwyr, Wzyr);
grid on;

t = 0:Ts:100;
ramp = t;

figure;
lsim(Wwyr, ramp, t);
grid on;

figure;
lsim(Wzyr, ramp, t);
grid on;






























