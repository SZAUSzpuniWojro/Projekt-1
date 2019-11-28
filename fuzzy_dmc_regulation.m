function [y, u_out] = fuzzy_dmc_regulation(F1_lin_tab, FD_lin, h_lin_tab, t_sim, y_zad, init_inputs, init_states, l, height)

%PARAMETERS
%F1_lint_tab - (1x5) vector of F1 linearization points
%FD_lin - (scalar) input of FD linearization point
%h_lin_tab - (2x5) first row is h1 points of linearization, second row is h2 points of linearization
%t_sim - (scalar) simulation time
%y_zad - (scalar) setpoint
%init_inputs - (1x2) [F1, FD]
%init_states - (1x2) [h1_init, h2_init]
%l - (scalar) how many regulators
%height - (scalar) maximum height of second tank

if (l > 5) && (l < 2)
    disp('Liczba regulatorow powinna zawierac sie miedzy 2 a 5')
    return
end

switch l
    case 2
       membership_fun = load('fuzzy/eh2.mat');
    case 3
       membership_fun = load('fuzzy/eh3.mat');
    case 4
       membership_fun = load('fuzzy/eh4.mat');
    case 5
       membership_fun = load('fuzzy/eh5.mat');
    otherwise
       disp('Liczba regulatorow powinna byc calkowita liczba')
       return
end

mf = struct2cell(membership_fun);

%ode options
options = odeset('RelTol',1e-8,'AbsTol',1e-10);

%params
tau = 80;
T = 0.5;

D = 480;
N = 190;
Nu = 1;
lambda = 40;


%TODO: przygotowaæ funkcjê przynale¿noœci 

%Parametry startowe
F1_init = init_inputs(1);
Fd_init = init_inputs(2);
h1_init = init_states(1);
h2_init = init_states(2);


Gz_tab = cell(1,l); %transmitancje poszczegolnych regulatorow
s_tab = cell(1,l); %odpowiedz skokowa poszczegolnych regulatorow
M_tab = cell(1,l); %macierze dynamiczne poszczegolnych regulatorow
Mp_tab = cell(1,l); %macierze odpowiedzi swobodnej poszczegolnych regulatorow
K_tab = cell(1,l); %same as higher

LMBD = lambda*eye(Nu);

M = zeros(N, Nu);
Mp= zeros(N, D-1);


for reg = 1:l
    %tworzenie tablicy lokalnych transmitancji
    Gs = linear_model([h_lin_tab(1,reg), h_lin_tab(2,reg)], F1_lin_tab(reg), FD_lin, tau); %h_lin_tab troche nie tak bo to powinien byc wektor (1x2) h1 i h2
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

uk= ones((Gz_tab{1}.InputDelay(1)),1).*F1_init;
y = ones(t_sim, 1).*h2_init;
h = [h1_init, h2_init];

u_out = [F1_init];
u_prev = F1_init;

wages=[];

%Main
for k=2:t_sim
    if k >= (Gz_tab{1}.InputDelay(1)*T) %don't know bout that chief
        stateHandler = @(t,x) model(t,x,u, FD_lin); 
        [t, h] = ode45(stateHandler,[0 Gz_tab{1}.Ts],h(end, :), options);
        y(k) = h(end,2);
    end
    
    mf_val = y(k)*(100/height);
    if mf_val >100
        mf_val=100;
    end
    %obliczane sa wagi
    wages = evalfis(mf{1}, mf_val); %dla zakresu 0-20cm h2 '5' bo funkcja w zakresie 0-100
    
    %regulatory lokalne licza sterowanie
    dUk = 0;
    for reg=1:l
        yk=ones(N,1)*y(k);
 
        y0=yk+Mp_tab{reg}*dUp;
   
        dUk_reg=K_tab{reg}*(y_zad'-y0);
        dUk = dUk + dUk_reg * wages(reg);
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
