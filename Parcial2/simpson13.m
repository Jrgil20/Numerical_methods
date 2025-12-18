% --- DATOS ---
f = @(x) sqrt(1 + x.^2);
a = 0;
b = 2;
n = 20; % Debe ser PAR

% --- CÁLCULO ---
h = (b - a) / n;
x = a:h:b;
y = f(x);

% Sumatorias (Indices Octave: 2,4,6... son los impares de la fórmula x1,x3...)
S_impares = sum(y(2:2:end-1));
S_pares   = sum(y(3:2:end-2));

Area = (h/3) * (y(1) + 4*S_impares + 2*S_pares + y(end));

% --- RESULTADOS ---
fprintf('h = %.5f\n', h);
fprintf('f(a) + f(b)     = %.5f\n', y(1) + y(end));
fprintf('Suma Impares    = %.5f  (x4 -> %.5f)\n', S_impares, 4*S_impares);
fprintf('Suma Pares      = %.5f  (x2 -> %.5f)\n', S_pares, 2*S_pares);
fprintf('---------------------------\n');
fprintf('Área Total      = %.6f\n', Area);