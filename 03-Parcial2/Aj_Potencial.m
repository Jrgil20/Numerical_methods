% =================================================
%  AJUSTE POTENCIAL: y = b * x^a
%  Referencia: Guía PDF Páginas 4-5
% =================================================

% 1. DATOS DE ENTRADA (Ejemplo Guía Pag. 4)
x = [1.5; 2.0; 3.4; 4.1; 4.9; 6.1];
y = [0.3; 1.8; 3.9; 10.3; 15.4; 20.7];

% Asegurar vectores columna
x = x(:);
y = y(:);
n = length(x);

% 2. LINEALIZACIÓN
% Modelo: ln(y) = a*ln(x) + ln(b)  =>  Y = aX + c
X_lin = log(x);  % Logaritmo de X
Y_lin = log(y);  % Logaritmo de Y

% 3. CÁLCULO DE SUMATORIAS PARA LA MATRIZ
% La guía muestra un sistema de la forma:
% [ Sum(ln_x^2)  Sum(ln_x) ] [ a ] = [ Sum(ln_x*ln_y) ]
% [ Sum(ln_x)       n      ] [ c ]   [ Sum(ln_y)      ]

Sum_X2 = sum(X_lin.^2);
Sum_X  = sum(X_lin);
Sum_Y  = sum(Y_lin);
Sum_XY = sum(X_lin .* Y_lin);

% Construcción explícita de las matrices (Como en Pag. 5)
Matriz_Sistema = [Sum_X2, Sum_X;
                  Sum_X,  n    ];

Vector_Indep   = [Sum_XY;
                  Sum_Y];

% 4. MOSTRAR PASOS INTERMEDIOS
disp('-----------------------------------------');
disp('--- MATRICES DEL SISTEMA NORMAL (Pag. 5) ---');
disp('Matriz (lado izquierdo):');
disp(Matriz_Sistema);
disp('Vector (lado derecho):');
disp(Vector_Indep);

% 5. SOLUCIÓN DEL SISTEMA
incognitas = Matriz_Sistema \ Vector_Indep;

a = incognitas(1); % Pendiente (es el exponente directamente)
c = incognitas(2); % Intercepto (ln b)

% 6. RECUPERAR CONSTANTES ORIGINALES
b = exp(c);

% 7. RESULTADOS Y ERROR
disp('-----------------------------------------');
disp('--- RESULTADOS FINALES ---');
fprintf('a (exponente) = %.6f\n', a);
fprintf('c (intercepto)= %.6f\n', c);
fprintf('b (coeficiente)= %.6f\n', b);
fprintf('Ecuación: y = %.6f * x^(%.6f)\n', b, a);

% Validación Error
y_pred = b * (x .^ a);
error_total = sum((y - y_pred).^2);
fprintf('Error Cuadrático Total: %.6e\n', error_total);
disp('-----------------------------------------');