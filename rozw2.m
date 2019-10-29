function rozw2
V=[116.4281371; 3434.310019];
t = [0 2000]; % czas Symulacji
 
[tn,Vn] = ode45(@model,t, V); % Symulacja

figure(1)
plot(tn,Vn)
title('Model nieliniowy')
xlabel('Czas symulacji') 
ylabel('Objetosc wody w zbiorniku')
legend('V_{1}', 'V_{2}')
hold off

%V=[116.4281371; 3434.310019]

[tl,Vl] = ode45(@linear_model,t, V); % Symulacja

figure(2)
plot(tl,Vl)
title('Model zlinearyzowany')
xlabel('Czas symulacji') 
ylabel('Objetosc wody w zbiorniku')
legend('V_{1}', 'V_{2}')