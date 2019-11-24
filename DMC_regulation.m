function [y, u_out] = DMC_regulation(Gz, D, N, Nu, lambda, t_sim, y_zad, init_inputs, init_states)
%DMC_REGULATION 

%ode options
options = odeset('RelTol',1e-8,'AbsTol',1e-10);

%Parametry startowe
F1_init = init_inputs(1);
Fd_init = init_inputs(2);
h1_init = init_states(1);
h2_init = init_states(2);

%Odpowiedz skokowa
s = step(Gz, D/Gz.Ts);
s = s(:,:,1);

LMBD = lambda*eye(Nu);

%Wyznaczanie macierzy M
M = zeros(N, Nu);
for i=1:1:Nu
   M(i:N,i)=s(1:N-i+1)';
end

%Wyznaczanie macierzy Mp
Mp= zeros(N, D-1);
for i=1:N
    for j=1:D-1
        if i+j<=D
            Mp(i,j)=s(i+j)-s(j);
        else
            Mp(i,j)=s(D)-s(j);
        end
    end
end

%Wyznaczenie K - wektora wzmocnieñ
K=(M'*M + LMBD)^(-1)*M';


%Czesc dynamiczna
dUp=zeros(1,(D-1))';
y_zad(1:N)= y_zad;

uk= ones((Gz.InputDelay(1)),1).*F1_init;
y = ones(t_sim, 1).*h2_init;
h = [h1_init, h2_init];

u_out = [F1_init];
u_prev = F1_init;

%Main
for k=2:t_sim
    if k >= (Gz.InputDelay(1)) %don't know bout that chief
        stateHandler = @(t,x) model(t,x,u, Fd_init); 
        [t, h] = ode45(stateHandler,[0 Gz.Ts],h(end, :), options);
        y(k) = h(end,2);
    end
    
   yk=ones(N,1)*y(k);
 
   y0=yk+Mp*dUp;
   
   dUk=K*(y_zad'-y0);
   
   %Prawo regulacji
   u=u_prev+dUk(1);
   u_out = [u_out; u];
   u_prev = u;
 
   %Wyznaczenie zmian sterowania
   dUp=[dUk(1) dUp(1:end-1)']';
end

u_out = u_out';

end

