function w = create_wages(F1, FD, liczba_rozmytych)


F1b = [-20, -10, 0, 10, 20];
FDb = [-20, -10, 0, 10, 20];
%punkty h2  
%F1 = -20, -10, 0, 10, 20
%FD = -20, -10, 0, 10, 20
%Funkcja przynale¿noœci jest funkcj¹ sterowania (F1)
%w1 - przynale¿noœæ do zbioru (-20), w2 - przynale¿noœæ do (-10) itd..

if liczba_rozmytych == 2
    w1=0; w3=0; w5=0;
    
    F1_mi2 = max(min(1, (F1b(4)-F1)/(F1b(4)-F1b(2))), 0);
    F1_mi4 = max(min(1, (F1-F1b(2))/(F1b(4)-F1b(2))), 0);
    
    FD_mi2 = max(min(1, (FDb(4)-FD)/(FDb(4)-FDb(2))), 0);
    FD_mi4 = max(min(1, (FD-FDb(2))/(FDb(4)-FDb(2))), 0);
    
    w2 = F1_mi2 * FD_mi2;
    w4 = F1_mi4 * FD_mi4;
    

elseif liczba_rozmytych == 3
    w1=0; w5=0;
    
    a1 = F1b(2);
    b1 = F1b(3);
    c1 = F1b(4);
    
    aD = FDb(2);
    bD = FDb(3);
    cD = FDb(4);
    
    F1_mi2 = max(min(1, (b1-F1)/(b1-a1)), 0);
    F1_mi3 = max(min((F1-a1)/(b1 - a1), (c1-F1)/(c1-b1)) , 0);
    F1_mi4 = max(min((F1-b1)/(c1-b1) , 1), 0);
    
    FD_mi2 = max(min(1, (bD-FD)/(bD-aD)), 0);
    FD_mi3 = max(min((FD-aD)/(bD - aD), (cD-FD)/(cD-bD)) , 0);
    FD_mi4 = max(min((FD-bD)/(cD-bD) , 1), 0);
    
    w2 = F1_mi2 * FD_mi2;
    w3 = F1_mi3 * FD_mi3;
    w4 = F1_mi4 * FD_mi4;
    
elseif liczba_rozmytych == 4
    w1 = 0;
    
    a1 = F1b(2);
    b1 = F1b(3);
    c1 = F1b(4);
    d1 = F1b(5);
    
    aD = FDb(2);
    bD = FDb(3);
    cD = FDb(4);
    dD = FDb(5);
    
    F1_mi2 = max(min(1, (b1-F1)/(b1-a1)), 0);
    F1_mi3 = max(min((F1-a1)/(b1-a1) , (c1-F1)/(c1-b1)) , 0);
    F1_mi4 = max(min((F1-b1)/(c1-b1) , (d1-F1)/(d1-c1)),  0);
    F1_mi5 = max(min((F1-c1)/(d1-c1) , 1), 0);
    
    FD_mi2 = max(min(1, (bD-FD)/(bD-aD)), 0);
    FD_mi3 = max(min((FD-aD)/(bD-aD) , (cD-FD)/(cD-bD)) , 0);
    FD_mi4 = max(min((FD-bD)/(cD-bD) , (dD-FD)/(dD-cD)),  0);
    FD_mi5 = max(min((FD-cD)/(dD-cD) , 1), 0);
    
    w2 = F1_mi2 * FD_mi2;
    w3 = F1_mi3 * FD_mi3;
    w4 = F1_mi4 * FD_mi4;
    w5 = F1_mi5 * FD_mi5;
else 
    
    a1 = F1b(1);
    b1 = F1b(2);
    c1 = F1b(3);
    d1 = F1b(4);
    e1 = F1b(5);
    
    aD = FDb(1);
    bD = FDb(2);
    cD = FDb(3);
    dD = FDb(4);
    eD = FDb(5);

    F1_mi1 = max(min(1, (b1-F1)/(b1-a1)), 0);
    F1_mi2 = max(min((F1-a1)/(b1-a1) , (c1-F1)/(c1-b1)) , 0);
    F1_mi3 = max(min((F1-b1)/(c1-b1) , (d1-F1)/(d1-c1)),  0);
    F1_mi4 = max(min((F1-c1)/(d1-c1) , (e1-F1)/(e1-d1)), 0);
    F1_mi5 = max(min((F1-d1)/(e1-d1) , 1), 0);
    
    FD_mi1 = max(min(1, (bD-FD)/(bD-aD)), 0);
    FD_mi2 = max(min((FD-aD)/(bD-aD) , (cD-FD)/(cD-bD)) , 0);
    FD_mi3 = max(min((FD-bD)/(cD-bD) , (dD-FD)/(dD-cD)),  0);
    FD_mi4 = max(min((FD-cD)/(dD-cD) , (eD-FD)/(eD-dD)), 0);
    FD_mi5 = max(min((FD-dD)/(eD-dD) , 1), 0);
    
    w1 = F1_mi1 * FD_mi1;
    w2 = F1_mi2 * FD_mi2;
    w3 = F1_mi3 * FD_mi3;
    w4 = F1_mi4 * FD_mi4;
    w5 = F1_mi5 * FD_mi5;
end
w = [w1, w2, w3, w4, w5];
w_s = sum(w);
for i=1:size(w)
    w(i) = w(i)/w_s;
end



end

