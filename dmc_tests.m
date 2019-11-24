F1 = 52;
FD = 13;
tau = 80;
init_values = [11.7036, 7.9868]; %[h1, h2]

G = linear_model(init_values, F1, FD, tau);

D = 2;
N = 2;
Nu = 2;
lambda = 0.5;
sim_time = 1000;
y_zad = 20;

[y, uk] = DMC_regulation(G, D, N, Nu, lambda, sim_time, y_zad, [F1, FD], init_values);

plot(1:sim_time, [y, uk]);