function [values,t] = fuzzy_linear_sim(G, F1, FD, step_time, init_values, sim_time, liczba_rozmytych)
%G - vector of local transmitations

t = 0:0.1:sim_time;
signal_changes = zeros(length(t),2);
signal_changes(1,:) = [F1(1), FD(1)];
current_F1 = F1(1);
current_FD = FD(1);

w = zeros(length(t), 5);
values = init_values;
for i=2:length(t)
    if t(i) == step_time(1) && t(i) == step_time(2)
        current_F1 = F1(2);
        current_FD = FD(2);
    elseif t(i) == step_time(1) 
        current_F1 = F1(2);
    elseif  t(i) == step_time(2)
        current_FD = FD(2);
    end
    w(i,:) = create_wages(current_F1, current_FD, liczba_rozmytych);
    signal_changes(i,:) = [current_F1, current_FD];
    
    x_counter = [0,0]; 
    y_counter = 0;
    t_temp = [t(i-1), t(i)];
    for j = 1:5
        [y_temp,trash,x_temp] = lsim(G(j),signal_changes(i-1:i,:),t_temp, values(i-1,:));
        y_temp = y_temp*w(i,j);
        x_temp = x_temp*w(i,j);
        
        x_counter = x_counter + x_temp(2,:);
        y_counter = y_counter + y_temp(2);
    end
    values = [values;x_counter];
end

end

