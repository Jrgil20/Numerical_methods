% --- DATOS ---
f = @(x) sqrt(1 + x.^2);
a = 0;
b = 2;
n = 30; % Debe ser Múltiplo de 3

% --- CÁLCULO ---
h = (b - a) / n;
x = a:h:b;
y = f(x);

sum_multiplos3 = 0;
sum_resto = 0;

for k = 1:n-1
    if mod(k, 3) == 0
        sum_multiplos3 = sum_multiplos3 + y(k+1);
    else
        sum_resto = sum_resto + y(k+1);
    end
end

Area = (3*h/8) * (y(1) + 3*sum_resto + 2*sum_multiplos3 + y(end));

% --- RESULTADOS ---
fprintf('h = %.5f\n', h);
fprintf('f(a) + f(b)      = %.5f\n', y(1) + y(end));
fprintf('Suma "Resto"     = %.5f  (x3 -> %.5f)\n', sum_resto, 3*sum_resto);
fprintf('Suma Múltiplos 3 = %.5f  (x2 -> %.5f)\n', sum_multiplos3, 2*sum_multiplos3);
fprintf('---------------------------\n');
fprintf('Área Total       = %.6f\n', Area);