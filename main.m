clear all;
close all;
 
F1p=52;
FDp=13;
tau=80;
h2p=7.98;
h1p=11.7;
Ts = 0.1;

F1_step_val = 0;
FD_step_val = 0;


F1=[F1p, F1p+ F1_step_val];
FD=[FDp, FDp+ FD_step_val];
step_time = [500, 1200];
sim_time = 5000;
[t1,x1] = nonlinear_sim(F1,FD,tau, step_time,[h1p, h2p], sim_time);
 

figure(1);
hold on;
plot(t1,x1);
legend('h1','h2');
xlabel('Czas [s]');
ylabel('Wysokoœæ [cm]');
 
F1=[0, F1_step_val];
FD=[0, FD_step_val];

G_lin = linear_model([h1p,h2p], F1p, FDp, tau);
[y,t,x] = linear_sim(G_lin, F1, FD, step_time, [0, 0], sim_time);
x = x + ones(size(x)).*[h1p,h2p];
plot(t,x(:,2));

w = create_wages(F1_step_val, FD_step_val, 2)