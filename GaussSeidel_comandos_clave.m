% Gauss-Seidel: Comandos Clave
% Resuelve: Ax = b
% Diferencia: Usa valores recién calculados en la misma iteración

% Definir el sistema
A = [10 -1 2; -1 11 -1; 2 -1 10];
b = [6; 25; -11];
x0 = [0; 0; 0];
tol = 0.0001;

% Inicializar
n = length(b);
x = x0;
k = 0;
error = inf;

% Iteración principal
while error > tol
    x_anterior = x;
    for i = 1:n
        suma = A(i, 1:i-1) * x(1:i-1) + A(i, i+1:n) * x_anterior(i+1:n);
        x(i) = (b(i) - suma) / A(i, i);
    end
    error = norm(x - x_anterior) / norm(x);
    k = k + 1;
    fprintf('Iteración %d: x = [%g %g %g], error = %.6f\n', k, x(1), x(2), x(3), error);
end

% Resultado
disp(x);
fprintf('Iteraciones: %d\n', k);
