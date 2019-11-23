function [w1,w2,w3,w4,w5] = create_wages(F1, liczba_rozmytych)


%punkty h2  
%F1 = -20, -10, 0, 10, 20
%FD = -20, -10, 0, 10, 20
%Funkcja przynale¿noœci jest funkcj¹ sterowania (F1)
%w1 - przynale¿noœæ do zbioru (-20), w2 - przynale¿noœæ do (-10) itd..

if liczba_rozmytych == 2
    [w1,w3,w5] = zeros(3);
    % code here
elseif liczba_rozmytych == 3
    [w2,w4] = zeros(2);
    % code here
elseif liczba_rozmytych == 4
    w1 = 0;
   % code here
else 
    % code here



end

