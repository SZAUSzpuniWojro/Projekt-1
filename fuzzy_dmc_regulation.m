function [y, u_out] = fuzzy_dmc_regulation(F1_lin_tab, FD_lin, h2_lin_tab, t_sim, y_zad, init_inputs, init_states)

%ode options
options = odeset('RelTol',1e-8,'AbsTol',1e-10);

%params
tau = 80;
T = 0.1;

D = 480;
N = 190;
Nu = 1;
lambda = 100;


%TODO: przygotowaæ funkcjê przynale¿noœci 

%Parametry startowe
F1_init = init_inputs(1);
Fd_init = init_inputs(2);
h1_init = init_states(1);
h2_init = init_states(2);


Gz_tab = cell(1,5);
s_tab = cell(1,5);
M_tab = cell(1,5);
Mp_tab = cell(1,5);
K_tab = cell(1,5);

LMBD = lambda*eye(Nu);

M = zeros(N, Nu);
Mp= zeros(N, D-1);


for reg = 1:5
    %tworzenie tablicy lokalnych transmitancji
    Gs = linear_model(h2_lin_tab(reg), F1_lin_tab(reg), FD_lin, tau); 
    Gz_tab{reg} = c2d(tf(Gs),T,'zoh');
    
    %Odpowiedz skokowa
    s = step(Gz_tab{reg}, D/Gz_tab{reg}.Ts);
    s_tab{reg} = s(:,:,1);
    
    %Wyznaczanie macierzy M
    for i=1:Nu
        M(i:N,i)=s(1:N-i+1)';
    end
    M_tab{reg} = M;
    
    %Wyznaczanie macierzy Mp
    for i=1:N
        for j=1:D-1
            if i+j<=D
                Mp(i,j)=s(i+j)-s(j);
            else
                Mp(i,j)=s(D)-s(j);
            end
        end
    end
    Mp_tab{reg} = Mp;
    
    %Wyznaczenie K - wektora wzmocnieñ
    K_tab{reg}=(M'*M + LMBD)^(-1)*M';
end


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
    if k >= (Gz_tab{1}.InputDelay(1)) %don't know bout that chief
        stateHandler = @(t,x) model(t,x,u, uk(k - (Gz_tab{1}.InputDelay(1)))); 
        [t, h] = ode45(stateHandler,[0 Gz_tab{1}.Ts],h(end, :), options);
        y(k) = h(end,2);
    end
    
    %obliczane s¹ wagi
    %----TODO----%
    
    %regulatory lokalne licza sterowanie
    dUk = 0;
    for reg=1:5
        yk=ones(N,1)*y(k);
 
        y0=yk+Mp_tab{reg}*dUp;
   
        dUk_reg=K_tab{reg}*(y_zad'-y0);
        % dUk = dUk + dUk_reg * (waga regulatora)  --- TODO ---
    end
   
   
   %Prawo regulacji
   u=u_prev+dUk;
   u_out = [u_out; u];
   u_prev = u;
   
   %Wyznaczenie zmian sterowania
   dUp=[dUk(1) dUp(1:end-1)']';
end

u_out = u_out';

end
