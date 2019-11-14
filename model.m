function [h_dot] = model(t,h,F_1, F_D)

%parameters
C1 = 0.85;
A2 = 430;
a1 = 19;
a2 = 23;

%equations
h_dot = zeros(2,1);
h_dot(1) = (1/(2*C1*h(1)))*(F_1 + F_D - a1*sqrt(h(1)));
h_dot(2) = (1/(A2))*(a1*sqrt(h(1)) - a2*sqrt(h(2)));
end