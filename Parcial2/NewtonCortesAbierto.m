% ======================================================
%  SOLUCIONADOR GENÉRICO NEWTON-COTES (ABIERTO)
%  Replica la lógica del PROGRAMA 4-3 (Fórmulas Abiertas)
% ======================================================

% 1. BASE DE DATOS DE COEFICIENTES (ABIERTOS)
% Estructura: {Pesos...}, Numerador(Q), Denominador(R), Nombre
% n = Número de puntos INTERNOS
DB_OpenNC = {
    [1],                2, 1, 'n=1: Regla del Punto Medio';
    [1, 1],             3, 2, 'n=2: Trapecio Abierto (Two-point)';
    [2, -1, 2],         4, 3, 'n=3: Regla de Milne';
    [11, 1, 1, 11],     5, 24,'n=4: Regla Abierta de 4 puntos'
};

% 2. CONFIGURACIÓN USUARIO
f = @(x) sin(x);      % Función a integrar
a = 0;                % Límite inferior
b = pi/2;             % Límite superior
n = 3;                % NÚMERO DE PUNTOS INTERNOS (1 a 4)

% 3. EXTRACCIÓN DE PARÁMETROS
if n < 1 || n > 4
    error('Número de puntos n no soportado en esta demo.');
end

Weights = DB_OpenNC{n, 1};
Q = DB_OpenNC{n, 2};
R = DB_OpenNC{n, 3};
Nombre = DB_OpenNC{n, 4};

% 4. EJECUCIÓN DEL ALGORITMO
% OJO: En formulas abiertas, h = (b-a) / (n+1)
h = (b - a) / (n + 1);

% Generamos solo los puntos INTERNOS
% x_i = a + i*h, para i=1 hasta n
indices = 1:n;
x = a + indices * h;
y = f(x);

% 5. CÁLCULO (Sumatoria Ponderada)
ANS = 0;
fprintf('--- Traza del Algoritmo (%s) ---\n', Nombre);
fprintf('Factor Global (Q*h/R) = %d*h/%d\n', Q, R);

for J = 1:n
    peso = Weights(J);
    valor = y(J);
    aporte = peso * valor;
    ANS = ANS + aporte;
    
    fprintf('Punto Interno %d (x=%.4f): f=%.4f * W=%d -> Acum: %.4f\n', ...
            J, x(J), valor, peso, ANS);
end

% Ajuste Final de la Fórmula: (Q * h / R) * Suma
Factor = (Q * h) / R;
Resultado = ANS * Factor;

fprintf('----------------------------------\n');
fprintf('RESULTADO FINAL = %.8f\n', Resultado);
fprintf('----------------------------------\n');