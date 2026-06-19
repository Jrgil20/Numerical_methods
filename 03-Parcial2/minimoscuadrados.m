% --- DATOS (Caso Diapositiva 16) ---
x = [1; 2; 3; 4; 5];
y = [2; 3; 5; 4; 6];
n = 2;

% --- PROCESAMIENTO ---
x = x(:);
y = y(:);

% 1. Construcción de A
A = [];
for p = 0:n
    A = [A, x.^p];
end

% IMPRIMIR MATRIZ A (Vandermonde)
disp('--- Paso 1: Matriz de Diseño A (Vandermonde) ---');
disp(A);

% 2. Construcción de Normales
M = A' * A;
B = A' * y;

% IMPRIMIR SISTEMA NORMAL
disp('--- Paso 2: Matriz A transpuesta * A ---');
disp(M);

disp('--- Paso 3: Vector A transpuesta * y ---');
disp(B);

% 3. Solución
coefs = A \ y;

% IMPRIMIR RESULTADOS
disp('--- Paso 4: Coeficientes Solución ---');
disp(coefs);

% 4. Cálculo del Error y Validación
y_pred = A * coefs;              % Calculamos qué valor predice nuestro polinomio
residuo = y - y_pred;            % Calculamos la diferencia con el valor real
error_total = sum(residuo.^2);   % Elevamos al cuadrado y sumamos

% IMPRIMIR ERROR
disp('--- Paso 5: Error Cuadrático Total ---');
disp(error_total);

% (Opcional) Ver los valores uno al lado del otro
disp('--- Comparación: Real vs Predicho ---');
disp([y, y_pred]);