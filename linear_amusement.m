function h_2 = linear_amusement(h_lin, F_1_lin, F_D_lin, F_1, F_D)

    a_1 = 19;
    a_2 = 23;

    h_1 = (F_1+F_1_lin+F_D+F_D_lin-((a_1*h_lin(1))/(2*sqrt(h_lin(1))))-(a_1/sqrt(h_lin(1)^3)))/(F_1_lin/h_lin(1)+F_D_lin/h_lin(1)-a_1/(2*sqrt(h_lin(1))));
    h_2 = (a_1*(sqrt(h_lin(1))-h_lin(1)/(2*sqrt(h_lin(1)))+h_1/(2*sqrt(h_lin(1))))-a_2*(sqrt(h_lin(2))-h_lin(2)/(2*sqrt(h_lin(2)))))/(a_2/(2*sqrt(h_lin(2))));

end