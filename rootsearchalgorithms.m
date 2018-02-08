%% Busqueda de raices: Metodo binomial
L = [-5 -4]; % limites [Inferior Superior]
NL = abs(L(2)-L(1)); % Norma del vector
i = 0; formatSpec = 'Iteration number: %d \n';
tic
while NL > 10^-13
    D = (L(1) + L(2))/2;
    if (fx(L(1))*fx(D)) < 0
        L = [L(1) D];
    elseif (fx(L(2))*fx(D)) < 0
        L = [D L(2)];
    else
        break;
    end
    i = i + 1;
    NL = abs(L(2)-L(1));
    %fprintf(formatSpec,i)
end
toc
%% Busqueda de raices: Proporción áurea
Aurea = (sqrt(5) - 1)/2;
% Correspondientes a los extremos x1 y x2, y al punto interno x3
L = [-10 0]; 
NL = abs(L(2)-L(1)); % Norma del vector
i = 0; formatSpec = 'Iteration number: %d \n';
tic
while NL > 10^-13
    D = (L(2)*(1-Aurea)) + (L(1)*Aurea);
    if (fx(L(1))*fx(D)) < 0
        L = [L(1) D];
    elseif (fx(L(2))*fx(D)) < 0
        L = [D L(2)];
    else
        break;
    end
    i = i + 1;
    NL = abs(L(2)-L(1));
    %fprintf(formatSpec,i)
end
toc
%% Metodo de la secante
L = [-5 -2]; % x1 y x2
NL = abs(L(2)-L(1)); % Norma del vector
i = 0; formatSpec = 'Iteration number: %d \n';
tic
while NL > 10^-13
    m =  (fx(L(2)) - fx(L(1)))/(L(2) - L(1));
    k = L(2) - (fx(L(2))/(m+eps)); %L(3).....L(N)
    L = [L(2) k];
    NL = abs(L(2)-L(1));
end
toc
%% Metodo Newton-Raphson
delta =  0.01;
x0 = -5; % Valor inicial
d = 0.1; % Diferencia inical
tic
while d > 10^-13
    dif = (fx(x0+delta) - fx(x0))/delta; % Derivada
    x1 = x0 - (fx(x0)/dif); % Newton-Raphson
    d = abs(x1 - x0); x0 = x1;
end
toc
%% Verificacion
roots([300,sqrt(2)*1000,0,0,-470,0,0,25])