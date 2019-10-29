function dVdt = model(t, V)

%sta³e modelu
a1 = 19;
a2 = 23; 
A2 = 430; %cm^2
C1 = 0.85;

%punkt pracy
Fd = 13; %cm^3/s
tau = 80;

%opóŸnienie
%if ( t < tau)
 %   F1 = 0;
%else
    F1 = 52;
%end

%musi byæ nieujemne
if ( V(1) < 0)
    V(1) = 0;
end
if (V(2) < 0)
    V(2) = 0;
end


%V1 = C1 * h1^2 => h1 = sqrt(V1/C1)
%V2 = A2 * h2 => h2 = V2/A2

F2 = a1 * nthroot(V(1)/C1, 4);
F3 = a2 * nthroot(V(2)/A2, 2);
    
%esencja modelu
dVdt = [ F1 + Fd - F2; F2 - F3];
    
end