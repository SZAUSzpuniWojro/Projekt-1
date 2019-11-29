%clear;

t_sim = 5000;
y_zad = 30;
FD_lin = 13; 
height = 40; %(scalar) maximum height of second tank

init_states = [11.7036, 7.9868];
init_inputs = [52, 13];

l = 2; %(scalar) how many regulators

%Przykladowe punkty linearyzacji
switch l
    case 2
       h_lin_tab = [height*1/3, height*2/3];
       [F_1, h_1] = static_characteristic(height*1/3, FD_lin);
       [F_12, h_12] = static_characteristic(height*2/3, FD_lin);
       F1_lin_tab = [F_1, F_12];
       h_lin_tab = [h_lin_tab; h_1, h_12];
    case 3
       h_lin_tab = [height*1/4, height*2/4, height*3/4];
       [F_1, h_1] = static_characteristic(height*1/4, FD_lin);
       [F_12, h_12] = static_characteristic(height*2/4, FD_lin);
       [F_13, h_13] = static_characteristic(height*3/4, FD_lin);
       F1_lin_tab = [F_1, F_12, F_13];
       h_lin_tab = [h_lin_tab; h_1, h_12, h_13];
    case 4
       h_lin_tab = [height*1/5, height*2/5, height*3/5, height*4/5];
       [F_1, h_1] = static_characteristic(height*1/5, FD_lin);
       [F_12, h_12] = static_characteristic(height*2/5, FD_lin);
       [F_13, h_13] = static_characteristic(height*3/5, FD_lin);
       [F_14, h_14] = static_characteristic(height*4/5, FD_lin);
       F1_lin_tab = [F_1, F_12, F_13, F_14];
       h_lin_tab = [h_lin_tab; h_1, h_12, h_13, h_14];
    case 5
       h_lin_tab = [height*1/6, height*2/6, height*3/6, height*4/6, height*5/6];
       [F_1, h_1] = static_characteristic(height*1/6, FD_lin);
       [F_12, h_12] = static_characteristic(height*2/6, FD_lin);
       [F_13, h_13] = static_characteristic(height*3/6, FD_lin);
       [F_14, h_14] = static_characteristic(height*4/6, FD_lin);
       [F_15, h_15] = static_characteristic(height*5/6, FD_lin);
       F1_lin_tab = [F_1, F_12, F_13, F_14, F_15];
       h_lin_tab = [h_lin_tab; h_1, h_12, h_13, h_14, h_15];
    otherwise
       disp('Liczba regulatorow powinna byc calkowita liczba')
       return
end

[y, u_out] = fuzzy_dmc_regulation(F1_lin_tab, FD_lin, h_lin_tab, t_sim, y_zad, init_inputs, init_states, l, height);

plot(1:t_sim, y);
hold on;
%plot(1:t_sim, u_out);
%legend('y','u');