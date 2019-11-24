clear all;
close all;
 
F1p=52;
FDp=13;
tau=80;
h2p=7.98;
h1p=11.7;
Ts = 0.1;

F1_step_val = 8;
FD_step_val = 2;


F1=[F1p, F1p+ F1_step_val];
FD=[FDp, FDp+ FD_step_val];
step_time = [10, 10];
sim_time = 1000;

[t1,x1] = nonlinear_sim(F1,FD,tau, step_time,[h1p, h2p], sim_time);

plot(t1,x1);
hold on;

G_lin = linear_model([h1p,h2p], F1p, FDp, tau);
[y,t,x] = linear_sim(G_lin, [0, F1_step_val], [0, FD_step_val], step_time, [0, 0], sim_time);
x = x + ones(size(x)).*[h1p,h2p];
plot(t,x);

w = create_wages(F1_step_val, FD_step_val, 2);

title(['Skok wartosci $F_1$ do ', num2str(F1(2)), ' w chwili ', num2str(step_time(1)), ', $F_d$ do ', num2str(FD(2)), ' w chwili ', num2str(step_time(2))], 'interpreter', 'latex')
legend('$h_1$ nlin','$h_2$ nlin', '$h_1$ lin','$h_2$ lin', 'interpreter', 'latex');
xlabel('Czas [s]');
ylabel('Wysokosc [cm]');

%print(['comp_models_3'],'-dpdf');