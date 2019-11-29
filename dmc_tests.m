%clear;

F1 = 52;
FD = 13;
tau = 80;
init_values = [11.7036, 7.9868]; %[h1, h2]

Gc = linear_model(init_values, F1, FD, tau);

T=0.5;
Gz = c2d(tf(Gc), T, 'zoh');
Gz.InputDelay = [tau/T,0];

D = 480;
N = 190;
Nu = 1;
lambda = 40; 
sim_time = 5000;
y_zad = 30;

[y, uk] = DMC_regulation(Gz, D, N, Nu, lambda, sim_time, y_zad, [F1, FD], init_values);

plot(1:sim_time, y);
hold on;
plot(1:sim_time, uk);
legend('y','u');