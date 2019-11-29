function G_lin = linear_model_SISO(h_lin, F_1_lin, F_D_lin, tau)

%parameters
C1 = 0.85;
A2 = 430;
a1 = 19;
a2 = 23;



%equations
%h_dot(1) = (1/(2*C1*h(1)))*(F_1 + F_D - a1*sqrt(h(1)));
%h_dot(2) = (1/(A2))*(a1*sqrt(h(1)) - a2*sqrt(h(2)));
%h_dot(2) zlinearyzowane = (1/A2) * (a1*(h_lin(1)+1/(2*h_lin(1).^(1/2))*(h(1)-h_lin(1))) - 


a11 = (1/(2*C1))*((-F_1_lin-F_D_lin)*h_lin(1).^(-2) + a1*(1/2)*h_lin(1).^(-3/2)); %TODO: Check this!!!
a12 = 0;
a21 = (1/A2)*a1*(1/(2*h_lin(1).^(1/2)));    %TODO: Really man, check this!!!
a22 =  -(1/A2)*a2*(1/(2*h_lin(2).^(1/2)));

b11 = h_lin(1).^(-1)*(1/(2*C1));


A = [ a11, a12; 
      a21, a22  ]; 
B = [ b11;
     0 ];
 
C = [0, 1];
D = 0;

G_lin = ss(A,B,C,D,'InputDelay',[tau]);


end