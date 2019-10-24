function rozw2
V = [0; 0];
t = [0 2000]; % czas Symulacji
 
[t,V] = ode45(@linear_model,t, V); % Symulacja
 
plot(t,V)
legend('V_{1}', 'V_{2}')