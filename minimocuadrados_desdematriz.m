% 1. INGRESAR LA MATRIZ A (Dada explícitamente en el problema)
%    Copiamos los datos de la Pag 3 de tu guía [cite: 25-31]
A = [
    1, 2.0, 4.00;
    1, 2.2, 4.84;
    1, 2.4, 5.76;
    1, 2.6, 6.76;
    1, 2.8, 7.84;
    1, 3.0, 9.00
];

% 2. OBTENER EL VECTOR Y
%    Como la guía no nos da la lista de 'y', la calculamos usando la función.
%    Truco de ingeniero: Los valores de 'x' están en la columna 2 de A.
x = A(:, 2);
y = 2 * (x + 1).^(1/3); % Función dada en el enunciado [cite: 21]

% ==========================================
% VERIFICACIÓN DE PASOS INTERMEDIOS (Según tu PDF)
% ==========================================

% Paso A: Calcular la Matriz de Coeficientes Normales (ATA)
% Debería darte:
% 6.00   15.0   38.2
% 15.0   38.2   99.0
% ...
ATA = A' * A;

disp('--- Matriz ATA (Debe coincidir con la guía)  ---');
disp(ATA);

% Paso B: Calcular el Vector Independiente (ATy)
% Debería darte: 18.2001, 45.7034, etc.
ATy = A' * y;

disp('--- Vector ATy (Debe coincidir con la guía) [cite: 36-39] ---');
disp(ATy);

% ==========================================
% SOLUCIÓN FINAL
% ==========================================

% Resolvemos el sistema
coeffs = ATA \ ATy;

disp('--- Coeficientes Calculados (a0, a1, a2)  ---');
disp(coeffs);

% Verificamos el Error (Opcional)
y_pred = A * coeffs;
Error = sum((y - y_pred).^2);
disp('--- Error calculado [cite: 46] ---');
disp(Error);