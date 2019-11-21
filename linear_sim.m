function [y,t,x] = linear_sim(G,F1,FD,step_time, init_values, sim_time)

t = 0:0.1:sim_time;
signal_changes = zeros(length(t),2);
signal_changes(1,:) = [F1(1), FD(1)];
current_F1 = F1(1);
current_FD = FD(1);

for i=1:length(t)
    if t(i) == step_time(1) && t(i) == step_time(2)
        current_F1 = F1(2);
        current_FD = FD(2);
    elseif t(i) == step_time(1) 
        current_F1 = F1(2);
    elseif  t(i) == step_time(2)
        current_FD = FD(2);
    end
    
    signal_changes(i,:) = [current_F1, current_FD];
end


[y,t,x]=lsim(G,signal_changes,t,init_values);
end

