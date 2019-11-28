function [F_1, h_1] = static_characteristic(h_2, F_D)
    a_1 = 19;
    a_2 = 23;

    h_1 = ((a_2*sqrt(h_2))/a_1)^2;
    F_1 = a_1*sqrt(h_1)-F_D;
end