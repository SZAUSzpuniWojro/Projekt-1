function [t,h] = nonlinear_sim(F1,FD, tau, step_time,init_values, sim_time)
 
%F1, FD - (2x1) values of F1 and FD where F1(1) is pre step and F1(2) is post step
%tau - (scalar) input delay
%step_time - (2x1) step time for F1 (1) and for FD (2)
%init_values - (2x1) initial values of h1 (1) and h2 (2)
%sim_time - (scalar) simulation time


%ode options
options = odeset('RelTol',1e-8,'AbsTol',1e-10);

%creating input signals
signal_changes = [0, F1(1), FD(1)];
current_F1 = F1(1);
current_FD = FD(1);
i = 1;
while i < sim_time
    if i == step_time(1) + tau  && i == step_time(2)
        current_F1 = F1(2);
        current_FD = FD(2);
        signal_changes = [signal_changes; i, current_F1, current_FD];
    elseif i == step_time(1) + tau 
        current_F1 = F1(2);
        signal_changes = [signal_changes; i, current_F1, current_FD];
    elseif  i == step_time(2)
        current_FD = FD(2);
        signal_changes = [signal_changes; i, current_F1, current_FD];
    end
    i = i+1;
end

signals = [signal_changes; sim_time, F1(2), FD(2)]';

%part that actually solves differential equations
h = [];
t = [];
 
signals_size = size(signals);
for i=1:(signals_size(2)-1)
    stateHandler = @(t,h) model(t,h ,signals(2,i), signals(3,i));
    [ode_t,ode_h]=ode45(stateHandler,[signals(1,i) signals(1,i+1)],init_values, options);
    t = [t ode_t(1:end-1,:)'];
    h = [h ode_h(1:end-1,:)'];
  
    init_values = ode_h(end,:);
end
 
t =[t sim_time];
h =[h init_values'];
 
end

