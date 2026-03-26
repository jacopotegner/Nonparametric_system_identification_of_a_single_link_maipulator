
clear;    
clc;      
close all;

% Uploading the files
disp('Loading data from manipulator1.mat...');
load('manipulator1.mat');

% Plot y1 and y2
figure('Name', 'Outputs', 'NumberTitle', 'off');

subplot(2, 1, 1);
plot(t, y1, 'b', 'LineWidth', 1.5);
title('Output y_1');
xlabel('Time [s]');
ylabel('y_1');
grid on;

subplot(2, 1, 2);
plot(t, y2, 'r', 'LineWidth', 1.5);
title('Output y_2');
xlabel('Time [s]');
ylabel('y_2');
grid on;

% Plot of the inputs
figure('Name', 'Inputs', 'NumberTitle', 'off');

subplot(2, 1, 1);
plot(t, u1, 'b', 'LineWidth', 1.5); hold on;
plot(t, u2, 'r--', 'LineWidth', 1.5);
title('u_1 and u_2');
xlabel('Time [s]');
ylabel('Position');
legend('u_1 ', 'u_2', 'Location', 'best');
grid on;

subplot(2, 1, 2);
plot(t, u1d, 'b', 'LineWidth', 1.5); hold on;
plot(t, u2d, 'r--', 'LineWidth', 1.5);
title('u_1d and u_2d');
xlabel('Time [s]');
ylabel('Speed');
legend('u_1d', 'u_2d', 'Location', 'best');
grid on;

% Calculates the derivatives to find acceleration
u1dd = derivative(u1d, Ts);
u2dd = derivative(u2d, Ts);

figure('Name', 'Acceleration', 'NumberTitle', 'off');

plot(t, u1d_dot, 'b', 'LineWidth', 1.5); hold on;
plot(t, u2d_dot, 'r--', 'LineWidth', 1.5);
title('u_1dd and u_2dd');
xlabel('Time [s]');
ylabel('Acceleration');
legend('u_1d', 'u_{2d}', 'Location', 'best');
grid on;

% Creating the input matrix for the 2 inputs

x1 = [u1, u1d, u1d_dot];
x2 = [u2, u2d, u2d_dot];

lambda = 10;
beta = 100;
sigma2 = 4.2;

% Creating identity matrix
I_N = eye(N);

K11 = lambda * Cauchy_kernel(x1, x1, beta);
K21 = lambda * Cauchy_kernel(x2, x1, beta);

y2_hat = K21 * ((K11 + sigma2 * I_N)\ y1);

% Plot and compares the MAP with the real value
figure;
plot(y2, 'b', 'DisplayName', 'Recorded output (y2)'); hold on;
plot(y2_hat, 'r--', 'LineWidth', 1.5, 'DisplayName', 'MAP estimate');
xlabel('Samples');
ylabel('[Nm]');
legend;
title('Model validation');
grid on;

lambda2 = 0.1;
beta3 = 1;

% Repeating the process with a different lambda
K11 = lambda2 * Cauchy_kernel(x1, x1, beta);
K21 = lambda2 * Cauchy_kernel(x2, x1, beta);


y2_hat = K21 * ((K11 + sigma2 * I_N)\ y1);

figure;
plot(y2, 'b', 'DisplayName', 'Recorded output (y2)'); hold on;
plot(y2_hat, 'r--', 'LineWidth', 1.5, 'DisplayName', 'MAP estimate');
xlabel('Samples');
ylabel('[Nm]');
legend;
title('Model validation');
grid on;

% Repeating the process with a different beta
K11 = lambda * Cauchy_kernel(x1, x1, beta3);
K21 = lambda * Cauchy_kernel(x2, x1, beta3);

y2_hat = K21 * ((K11 + sigma2 * I_N)\ y1);


figure;
plot(y2, 'b', 'DisplayName', 'Recorded output (y2)'); hold on;
plot(y2_hat, 'r--', 'LineWidth', 1.5, 'DisplayName', 'MAP estimate');
xlabel('Samples');
ylabel('[Nm]');
legend;
title('Model validation');
grid on;

% Calculating yf
w = zeros(N, 1);
w(11:end) = 10;
wd = derivative(w, Ts);
wdd = derivative(wd, Ts);
xf = [w, wd, wdd];
K11 = lambda * Cauchy_kernel(x1, x1, beta3);
K_f1 = lambda * Cauchy_kernel(xf, x1, beta3);
yf = K_f1 * ((K11 + sigma2 * I_N)\ y1);


