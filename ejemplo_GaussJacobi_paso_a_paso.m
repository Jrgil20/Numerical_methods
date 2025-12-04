% =========================================================================
% GUÍA PASO A PASO: Método de Gauss-Jacobi en Octave
% =========================================================================
% Este archivo contiene los comandos que debes ejecutar uno a uno en Octave
% para resolver un sistema de ecuaciones lineales usando Gauss-Jacobi
% =========================================================================

% PASO 1: Definir el sistema de ecuaciones
% Ejemplo: Resolver el sistema Ax = b
% 10x₁ - x₂ + 2x₃ = 6
% -x₁ + 11x₂ - x₃ = 25
% 2x₁ - x₂ + 10x₃ = -11

matriz_coeficientes = [10 -1 2; -1 11 -1; 2 -1 10];
vector_independientes = [6; 25; -11];

% PASO 2: Definir valores iniciales para las variables
% Usaremos un vector de ceros como punto de partida
valores_iniciales = [0; 0; 0];

% PASO 3: Definir parámetros de convergencia
% Opción A: Usar error relativo como criterio de parada
error_tolerancia = 0.0001;  % 0.01% de tolerancia
num_iteraciones_max = [];   % Dejar vacío para usar error_tolerancia

% PASO 4: Mostrar el sistema a resolver
disp('===== SISTEMA DE ECUACIONES =====');
disp('Matriz de coeficientes A:');
disp(matriz_coeficientes);
disp('Vector de términos independientes b:');
disp(vector_independientes);
disp('Valores iniciales:');
disp(valores_iniciales);
disp('Error tolerancia: '); disp(error_tolerancia);

% =========================================================================
% INICIO DEL MÉTODO GAUSS-JACOBI (ejecutar línea por línea)
% =========================================================================

% PASO 5: Crear variable para almacenar todas las iteraciones
num_variables = length(vector_independientes);
num_iteraciones = 100;  % Máximo de iteraciones a realizar

% Inicializar matrices para guardar valores y errores
valores_iteracion = zeros(num_iteraciones, num_variables);
error_relativo = zeros(num_iteraciones, num_variables);

% Establecer los valores iniciales en la primera fila
valores_iteracion(1, :) = valores_iniciales;

disp(' ');
disp('===== EJECUTANDO GAUSS-JACOBI =====');

% =========================================================================
% ITERACIÓN 1
% =========================================================================
% PASO 6: Primera iteración (k=1)
% Fórmula: x_i^(k+1) = (b_i - suma(a_ij * x_j^(k))) / a_ii

% Para x₁:
x1_nuevo = (vector_independientes(1) - matriz_coeficientes(1, 2)*valores_iteracion(1, 2) - matriz_coeficientes(1, 3)*valores_iteracion(1, 3)) / matriz_coeficientes(1, 1);
% Para x₂:
x2_nuevo = (vector_independientes(2) - matriz_coeficientes(2, 1)*valores_iteracion(1, 1) - matriz_coeficientes(2, 3)*valores_iteracion(1, 3)) / matriz_coeficientes(2, 2);
% Para x₃:
x3_nuevo = (vector_independientes(3) - matriz_coeficientes(3, 1)*valores_iteracion(1, 1) - matriz_coeficientes(3, 2)*valores_iteracion(1, 2)) / matriz_coeficientes(3, 3);

% Guardar valores de esta iteración
valores_iteracion(2, 1) = x1_nuevo;
valores_iteracion(2, 2) = x2_nuevo;
valores_iteracion(2, 3) = x3_nuevo;

% Calcular error relativo para cada variable: |x_nuevo - x_anterior| / |x_nuevo|
error_relativo(2, 1) = abs((valores_iteracion(2, 1) - valores_iteracion(1, 1)) / valores_iteracion(2, 1)) * 100;
error_relativo(2, 2) = abs((valores_iteracion(2, 2) - valores_iteracion(1, 2)) / valores_iteracion(2, 2)) * 100;
error_relativo(2, 3) = abs((valores_iteracion(2, 3) - valores_iteracion(1, 3)) / valores_iteracion(2, 3)) * 100;

disp('Iteración 1:');
fprintf('x₁ = %.6f,  x₂ = %.6f,  x₃ = %.6f\n', valores_iteracion(2, 1), valores_iteracion(2, 2), valores_iteracion(2, 3));
fprintf('Error₁ = %.4f%%, Error₂ = %.4f%%, Error₃ = %.4f%%\n', error_relativo(2, 1), error_relativo(2, 2), error_relativo(2, 3));

% VERIFICA: ¿Los errores son menores que la tolerancia (0.01%)?
% Si NO, continúa a la siguiente iteración

% =========================================================================
% ITERACIÓN 2 (igual al anterior, pero usando valores_iteracion(2,:))
% =========================================================================

% PASO 7: Segunda iteración (k=2)
x1_nuevo = (vector_independientes(1) - matriz_coeficientes(1, 2)*valores_iteracion(2, 2) - matriz_coeficientes(1, 3)*valores_iteracion(2, 3)) / matriz_coeficientes(1, 1);
x2_nuevo = (vector_independientes(2) - matriz_coeficientes(2, 1)*valores_iteracion(2, 1) - matriz_coeficientes(2, 3)*valores_iteracion(2, 3)) / matriz_coeficientes(2, 2);
x3_nuevo = (vector_independientes(3) - matriz_coeficientes(3, 1)*valores_iteracion(2, 1) - matriz_coeficientes(3, 2)*valores_iteracion(2, 2)) / matriz_coeficientes(3, 3);

valores_iteracion(3, 1) = x1_nuevo;
valores_iteracion(3, 2) = x2_nuevo;
valores_iteracion(3, 3) = x3_nuevo;

error_relativo(3, 1) = abs((valores_iteracion(3, 1) - valores_iteracion(2, 1)) / valores_iteracion(3, 1)) * 100;
error_relativo(3, 2) = abs((valores_iteracion(3, 2) - valores_iteracion(2, 2)) / valores_iteracion(3, 2)) * 100;
error_relativo(3, 3) = abs((valores_iteracion(3, 3) - valores_iteracion(2, 3)) / valores_iteracion(3, 3)) * 100;

disp('Iteración 2:');
fprintf('x₁ = %.6f,  x₂ = %.6f,  x₃ = %.6f\n', valores_iteracion(3, 1), valores_iteracion(3, 2), valores_iteracion(3, 3));
fprintf('Error₁ = %.4f%%, Error₂ = %.4f%%, Error₃ = %.4f%%\n', error_relativo(3, 1), error_relativo(3, 2), error_relativo(3, 3));

% VERIFICA: ¿Los errores son menores que la tolerancia (0.01%)?
% Si NO, continúa a la siguiente iteración

% =========================================================================
% ITERACIÓN 3 Y SUCESIVAS
% =========================================================================
% PASO 8: Repetir el proceso anterior HASTA QUE TODOS LOS ERRORES
% SEAN MENORES QUE LA TOLERANCIA (0.0001 = 0.01%)
% 
% El patrón es siempre el mismo:
% 1. Usar los valores de la iteración anterior
% 2. Calcular nuevos valores con la fórmula de Gauss-Jacobi
% 3. Calcular los errores relativos
% 4. Mostrar resultados
% 5. Verificar si todos los errores < tolerancia

% Para no tener que escribir cada iteración, usa un BUCLE:

for iteracion = 3:100
    % Calcular nueva aproximación para cada variable
    x1_nuevo = (vector_independientes(1) - matriz_coeficientes(1, 2)*valores_iteracion(iteracion, 2) - matriz_coeficientes(1, 3)*valores_iteracion(iteracion, 3)) / matriz_coeficientes(1, 1);
    x2_nuevo = (vector_independientes(2) - matriz_coeficientes(2, 1)*valores_iteracion(iteracion, 1) - matriz_coeficientes(2, 3)*valores_iteracion(iteracion, 3)) / matriz_coeficientes(2, 2);
    x3_nuevo = (vector_independientes(3) - matriz_coeficientes(3, 1)*valores_iteracion(iteracion, 1) - matriz_coeficientes(3, 2)*valores_iteracion(iteracion, 2)) / matriz_coeficientes(3, 3);
    
    % Guardar valores
    valores_iteracion(iteracion + 1, 1) = x1_nuevo;
    valores_iteracion(iteracion + 1, 2) = x2_nuevo;
    valores_iteracion(iteracion + 1, 3) = x3_nuevo;
    
    % Calcular errores
    error_relativo(iteracion + 1, 1) = abs((valores_iteracion(iteracion + 1, 1) - valores_iteracion(iteracion, 1)) / valores_iteracion(iteracion + 1, 1)) * 100;
    error_relativo(iteracion + 1, 2) = abs((valores_iteracion(iteracion + 1, 2) - valores_iteracion(iteracion, 2)) / valores_iteracion(iteracion + 1, 2)) * 100;
    error_relativo(iteracion + 1, 3) = abs((valores_iteracion(iteracion + 1, 3) - valores_iteracion(iteracion, 3)) / valores_iteracion(iteracion + 1, 3)) * 100;
    
    % Mostrar resultados de esta iteración
    fprintf('Iteración %d: x₁ = %.6f (E=%.4f%%), x₂ = %.6f (E=%.4f%%), x₃ = %.6f (E=%.4f%%)\n', ...
        iteracion, valores_iteracion(iteracion + 1, 1), error_relativo(iteracion + 1, 1), ...
        valores_iteracion(iteracion + 1, 2), error_relativo(iteracion + 1, 2), ...
        valores_iteracion(iteracion + 1, 3), error_relativo(iteracion + 1, 3));
    
    % ¡¡¡ VERIFICA AQUÍ !!!
    % ¿TODOS los errores (Error₁, Error₂, Error₃) son MENORES que 0.0001 (0.01%)?
    % Si la respuesta es SÍ para todas las variables, puedes parar
    % Si la respuesta es NO, el bucle seguirá iterando
    
    % Criterio de parada automático
    if all(error_relativo(iteracion + 1, :) < error_tolerancia)
        disp(' ');
        disp('===== ¡¡CONVERGENCIA ALCANZADA!! =====');
        ultima_iteracion = iteracion + 1;
        break;
    end
end

% =========================================================================
% PASO 9: Mostrar resultados finales
% =========================================================================

disp(' ');
disp('===== RESULTADOS FINALES =====');
disp(sprintf('Número de iteraciones realizadas: %d', ultima_iteracion - 1));
disp(' ');
disp('Solución:');
fprintf('x₁ = %.8f\n', valores_iteracion(ultima_iteracion, 1));
fprintf('x₂ = %.8f\n', valores_iteracion(ultima_iteracion, 2));
fprintf('x₃ = %.8f\n', valores_iteracion(ultima_iteracion, 3));
disp(' ');

% =========================================================================
% PASO 10: Verificar la solución
% =========================================================================
% Calcular Ax para verificar que sea ≈ b

solucion = [valores_iteracion(ultima_iteracion, 1); valores_iteracion(ultima_iteracion, 2); valores_iteracion(ultima_iteracion, 3)];
residuo = matriz_coeficientes * solucion;

disp('Verificación: A*x =');
disp(residuo);
disp(' ');
disp('Debería ser aproximadamente igual a b =');
disp(vector_independientes);
disp(' ');
disp('Error de verificación (||Ax - b||):');
error_verificacion = norm(residuo - vector_independientes);
fprintf('%.8e\n', error_verificacion);

% =========================================================================
% NOTAS ADICIONALES
% =========================================================================
% 
% • En cada iteración, SIEMPRE usamos los valores de la iteración ANTERIOR
%   para calcular los nuevos valores (característica de Gauss-Jacobi)
%
% • El error relativo nos dice qué tan diferente es la solución actual
%   con respecto a la anterior
%
% • Cuando TODOS los errores son menores que la tolerancia, 
%   la solución ha convergido
%
% • Si necesitas cambiar el sistema, modifica:
%   - matriz_coeficientes
%   - vector_independientes  
%   - valores_iniciales
%   - error_tolerancia
%
% • Para usar la función completa GaussJacobi.m, simplemente escribe:
%   [tabla_resultados, solucion] = GaussJacobi(matriz_coeficientes, vector_independientes, valores_iniciales, [], error_tolerancia);
%   tabla_resultados
