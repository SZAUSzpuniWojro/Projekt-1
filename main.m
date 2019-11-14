clear all;
close all;
 
F1p=52;
FDp=13;
tau=80;
h2p=7.98;
h1p=11.7;
Ts = 0.1;

 
F1=[F1p, F1p+10];
FD=[FDp, FDp+10];
step_time = [500, 1200];
sim_time = 5000;
[t1,x1] = nonlinear_sim(F1,FD,tau, step_time,[h1p, h2p], sim_time);
 
figure(1);
plot(t1,x1);
legend('h1','h2');
xlabel('Czas [s]');
ylabel('Wysokoœæ [cm]');
 