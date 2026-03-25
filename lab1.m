% SCRIPT MATLAB: Importazione e Plot dati "manipulator1.mat"

% 1. Pulizia dell'ambiente di lavoro
clear;      % Cancella le variabili nel workspace
clc;        % Pulisce la command window
close all;  % Chiude tutte le finestre dei grafici aperti

% 2. Caricamento dei dati
% Assicurati che il file 'manipulator1.mat' sia nella current folder di MATLAB
disp('Caricamento dei dati da manipulator1.mat...');
load('manipulator1.mat');

% 3. Plot delle Uscite (y1, y2)
figure('Name', 'Uscite del Manipolatore', 'NumberTitle', 'off');

% Grafico di y1
subplot(2, 1, 1);
plot(t, y1, 'b', 'LineWidth', 1.5);
title('Andamento dell''uscita y_1');
xlabel('Tempo [s]');
ylabel('y_1');
grid on;

% Grafico di y2
subplot(2, 1, 2);
plot(t, y2, 'r', 'LineWidth', 1.5);
title('Andamento dell''uscita y_2');
xlabel('Tempo [s]');
ylabel('y_2');
grid on;

% 4. Plot degli Ingressi e Riferimenti (u1/u1d, u2/u2d)
figure('Name', 'Ingressi e Segnali Desiderati', 'NumberTitle', 'off');

% Grafico di u1 e u2
subplot(2, 1, 1);
plot(t, u1, 'b', 'LineWidth', 1.5); hold on;
plot(t, u2, 'r--', 'LineWidth', 1.5);
title('Ingresso u_1 e ingresso u_2');
xlabel('Tempo [s]');
ylabel('Posizione');
legend('u_1 ', 'u_2', 'Location', 'best');
grid on;

% Grafico di u1d e u2d
subplot(2, 1, 2);
plot(t, u1d, 'b', 'LineWidth', 1.5); hold on;
plot(t, u2d, 'r--', 'LineWidth', 1.5);
title('Ingresso u_1d e ingresso u_2d');
xlabel('Tempo [s]');
ylabel('Velocità');
legend('u_1d', 'u_{2d}', 'Location', 'best');
grid on;

disp('Grafici generati con successo!');

u1d_dot = derivative(u1d, Ts);
% Calcolo della derivata di u2d
u2d_dot = derivative(u2d, Ts);

figure('Name', 'Accelerazione', 'NumberTitle', 'off');

plot(t, u1d_dot, 'b', 'LineWidth', 1.5); hold on;
plot(t, u2d_dot, 'r--', 'LineWidth', 1.5);
title('Ingresso u1d_dot e ingresso u2d_dot');
xlabel('Tempo [s]');
ylabel('Accelerazione');
legend('u_1d', 'u_{2d}', 'Location', 'best');
grid on;

% Creazione matrice di input x1
% Creazione matrice di input x1: col1 = u1, col2 = u1d, col3 = u1d_dot

x1 = [u1, u1d, u1d_dot];
x2 = [u2, u2d, u2d_dot];

lambda = 10;
beta = 100;
sigma2 = 4.2;

% Creiamo matrice identità
I_N = eye(N);

% Varianza del rumore w
K11 = lambda * Cauchy_kernel(x1, x1, beta);
K21 = lambda * Cauchy_kernel(x2, x1, beta);

y2_hat = K21 * ((K11 + sigma2 * I_N)\ y1);

figure;
plot(y2, 'b', 'DisplayName', 'Coppia Misurata (y2)'); hold on;
plot(y2_hat, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Stima MAP');
xlabel('Campioni');
ylabel('Coppia [Nm]');
legend;
title('Validazione del Modello: Reale vs Predetto');
grid on;

lambda2 = 0.1;
beta3 = 1;

% Varianza del rumore w
K11 = lambda2 * Cauchy_kernel(x1, x1, beta);
K21 = lambda2 * Cauchy_kernel(x2, x1, beta);


y2_hat = K21 * ((K11 + sigma2 * I_N)\ y1);

figure;
plot(y2, 'b', 'DisplayName', 'Coppia Misurata (y2)'); hold on;
plot(y2_hat, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Stima MAP');
xlabel('Campioni');
ylabel('Coppia [Nm]');
legend;
title('Validazione del Modello: Reale vs Predetto');
grid on;

% Varianza del rumore w
K11 = lambda * Cauchy_kernel(x1, x1, beta3);
K21 = lambda * Cauchy_kernel(x2, x1, beta3);

y2_hat = K21 * ((K11 + sigma2 * I_N)\ y1);

figure;
plot(y2, 'b', 'DisplayName', 'Coppia Misurata (y2)'); hold on;
plot(y2_hat, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Stima MAP');
xlabel('Campioni');
ylabel('Coppia [Nm]');
legend;
title('Validazione del Modello: Reale vs Predetto');
grid on;

w = zeros(N, 1);
w(11:end) = 10;
wd = derivative(w, Ts);
wdd = derivative(wd, Ts);
xf = [w, wd, wdd];
K11 = lambda * Cauchy_kernel(x1, x1, beta3);
K_f1 = lambda * Cauchy_kernel(xf, x1, beta3);
yf = K_f1 * ((K11 + sigma2 * I_N)\ y1);


