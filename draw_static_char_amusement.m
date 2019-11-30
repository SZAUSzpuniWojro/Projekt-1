clear all;

h2 = [];
a_1 = 19;
a_2 = 23;
FD_lin = 13;
F_D = 13;

zakres_F1 = 100;

for F1 = 0:zakres_F1
    h1 = ((F1 + FD_lin)/a_1)^2;
    h2 = [h2,(sqrt(h1)*a_1/a_2)^2];
end

plot(0:zakres_F1,h2)
hold on;

l =3;
height = 20;
tau = 80;

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
h_out = [];

switch l
    case 2
       h_lin_tab = [height*1/3, height*2/3];
       [F_1, h_1] = static_characteristic(height*1/3, FD_lin);
       [F_12, h_12] = static_characteristic(height*2/3, FD_lin);
       F1_lin_tab = [F_1, F_12];
       %h_lin_tab = [h_lin_tab; h_1, h_12];
       for F1 = 0:zakres_F1
           
           h1 = ((F1 + FD_lin)/a_1)^2;
           h2 = (sqrt(h1)*a_1/a_2)^2;
    
           mf_val = h2*(100/height);
           if mf_val >100
               mf_val=100;
           end
           
           wages = evalfis(mf{1}, mf_val);
           
           h_21 = linear_amusement([h_1, h_lin_tab(1)], F_1, FD_lin, F1, F_D);
           h_22 = linear_amusement([h_12, h_lin_tab(2)], F_12, FD_lin, F1, F_D);
          
           h_out = [h_out, (h_21*wages(1)+h_22*wages(2))];
       end
    case 3
       h_lin_tab = [height*1/4, height*2/4, height*3/4];
       [F_1, h_1] = static_characteristic(height*1/4, FD_lin);
       [F_12, h_12] = static_characteristic(height*2/4, FD_lin);
       [F_13, h_13] = static_characteristic(height*3/4, FD_lin);
       F1_lin_tab = [F_1, F_12, F_13];
       %h_lin_tab = [h_lin_tab; h_1, h_12, h_13];
       for F1 = 0:zakres_F1
           
           h1 = ((F1 + FD_lin)/a_1)^2;
           h2 = (sqrt(h1)*a_1/a_2)^2;
    
           mf_val = h2*(100/height);
           if mf_val >100
               mf_val=100;
           end
           
           wages = evalfis(mf{1}, mf_val);
           
           h_21 = linear_amusement([h_1, h_lin_tab(1)], F_1, FD_lin, F1, F_D);
           h_22 = linear_amusement([h_12, h_lin_tab(2)], F_12, FD_lin, F1, F_D);
           h_23 = linear_amusement([h_13, h_lin_tab(3)], F_13, FD_lin, F1, F_D);
           
           h_out = [h_out, (h_21*wages(1)+h_22*wages(2)+h_23*wages(3))];
       end
    case 4
       h_lin_tab = [height*1/5, height*2/5, height*3/5, height*4/5];
       [F_1, h_1] = static_characteristic(height*1/5, FD_lin);
       [F_12, h_12] = static_characteristic(height*2/5, FD_lin);
       [F_13, h_13] = static_characteristic(height*3/5, FD_lin);
       [F_14, h_14] = static_characteristic(height*4/5, FD_lin);
       F1_lin_tab = [F_1, F_12, F_13, F_14];
       %h_lin_tab = [h_lin_tab; h_1, h_12, h_13, h_14];
       for F1 = 0:zakres_F1
                      
           h1 = ((F1 + FD_lin)/a_1)^2;
           h2 = (sqrt(h1)*a_1/a_2)^2;
    
           mf_val = h2*(100/height);
           if mf_val >100
               mf_val=100;
           end
           
           wages = evalfis(mf{1}, mf_val);
           
           h_21 = linear_amusement([h_1, h_lin_tab(1)], F_1, FD_lin, F1, F_D);
           h_22 = linear_amusement([h_12, h_lin_tab(2)], F_12, FD_lin, F1, F_D);
           h_23 = linear_amusement([h_13, h_lin_tab(3)], F_13, FD_lin, F1, F_D);
           h_24 = linear_amusement([h_14, h_lin_tab(4)], F_14, FD_lin, F1, F_D);
           
           h_out = [h_out, (h_21*wages(1)+h_22*wages(2)+h_23*wages(3)+h_24*wages(4))];
       end
    case 5
       h_lin_tab = [height*1/6, height*2/6, height*3/6, height*4/6, height*5/6];
       [F_1, h_1] = static_characteristic(height*1/6, FD_lin);
       [F_12, h_12] = static_characteristic(height*2/6, FD_lin);
       [F_13, h_13] = static_characteristic(height*3/6, FD_lin);
       [F_14, h_14] = static_characteristic(height*4/6, FD_lin);
       [F_15, h_15] = static_characteristic(height*5/6, FD_lin);
       F1_lin_tab = [F_1, F_12, F_13, F_14, F_15];
       %h_lin_tab = [h_lin_tab; h_1, h_12, h_13, h_14, h_15];
       for F1 = 0:zakres_F1
                                 
           h1 = ((F1 + FD_lin)/a_1)^2;
           h2 = (sqrt(h1)*a_1/a_2)^2;
    
           mf_val = h2*(100/height);
           if mf_val >100
               mf_val=100;
           end
           
           wages = evalfis(mf{1}, mf_val);
           
           h_21 = linear_amusement([h_1, h_lin_tab(1)], F_1, FD_lin, F1, F_D);
           h_22 = linear_amusement([h_12, h_lin_tab(2)], F_12, FD_lin, F1, F_D);
           h_23 = linear_amusement([h_13, h_lin_tab(3)], F_13, FD_lin, F1, F_D);
           h_24 = linear_amusement([h_14, h_lin_tab(4)], F_14, FD_lin, F1, F_D);
           h_25 = linear_amusement([h_15, h_lin_tab(5)], F_15, FD_lin, F1, F_D);
           
           h_out = [h_out, (h_21*wages(1)+h_22*wages(2)+h_23*wages(3)+h_24*wages(4)+h_25*wages(5))];
       end
    otherwise
       disp('Liczba regulatorow powinna byc calkowita liczba')
       return
end

plot(0:zakres_F1,h_out)
