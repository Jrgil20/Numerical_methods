% =========================================================================
% GUÍA PASO A PASO: Método de Gauss-Seidel en Octave
% =========================================================================
% Este archivo contiene los comandos que debes ejecutar uno a uno en Octave
% para resolver un sistema de ecuaciones lineales usando Gauss-Seidel
% 
% DIFERENCIA CON JACOBI: En Seidel se usan los valores YA CALCULADOS
% en la misma iteración (no esperas a tener todos los nuevos valores)
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

% PASO 4: Definir factor de relajación (opcional)
% factor_relajacion = 1 significa sin relajación (Gauss-Seidel puro)
% factor_relajacion < 1 ralentiza la convergencia (subrelajación)
% factor_relajacion > 1 acelera la convergencia (sobrerrelajación)
factor_relajacion = 1;

% PASO 5: Mostrar el sistema a resolver
disp('===== SISTEMA DE ECUACIONES =====');
disp('Matriz de coeficientes A:');
disp(matriz_coeficientes);
disp('Vector de términos independientes b:');
disp(vector_independientes);
disp('Valores iniciales:');
disp(valores_iniciales);
disp('Error tolerancia: '); disp(error_tolerancia);
disp('Factor de relajación: '); disp(factor_relajacion);

% =========================================================================
% INICIO DEL MÉTODO GAUSS-SEIDEL (ejecutar línea por línea)
% =========================================================================

% PASO 6: Crear variable para almacenar todas las iteraciones
num_variables = length(vector_independientes);
num_iteraciones = 100;  % Máximo de iteraciones a realizar

% Inicializar matrices para guardar valores y errores
valores_iteracion = zeros(num_iteraciones, num_variables);
error_relativo = zeros(num_iteraciones, num_variables);

% Establecer los valores iniciales en la primera fila
valores_iteracion(1, :) = valores_iniciales;

disp(' ');
disp('===== EJECUTANDO GAUSS-SEIDEL =====');

% =========================================================================
% ITERACIÓN 1 - EXPLICADA PASO A PASO
% =========================================================================
% PASO 7: Primera iteración (k=1)
% 
% DIFERENCIA CLAVE CON JACOBI:
% En cada paso, usamos el valor RECIÉN CALCULADO si ya lo tenemos
% 
% Fórmula: x_i^(k+1) = lambda * valor_nuevo + (1-lambda) * valor_anterior
%
% donde: valor_nuevo = (b_i - suma(a_ij * x_j)) / a_ii
%        y la suma usa x_j^(k+1) si ya está calculado, sino x_j^(k)

disp(' ');
disp('--- ITERACIÓN 1 ---');

% Para x₁ (usamos valores_iteracion(1,:) que son todos ceros):
fprintf('Calculando x₁:\n');
fprintf('  x₁_nuevo = (b₁ - a₁₂*x₂^(0) - a₁₃*x₃^(0)) / a₁₁\n');
fprintf('  x₁_nuevo = (%.1f - %.1f*%.1f - %.1f*%.1f) / %.1f\n', ...
    vector_independientes(1), matriz_coeficientes(1,2), valores_iteracion(1, 2), ...
    matriz_coeficientes(1,3), valores_iteracion(1, 3), matriz_coeficientes(1,1));
x1_nuevo = (vector_independientes(1) - matriz_coeficientes(1, 2)*valores_iteracion(1, 2) - matriz_coeficientes(1, 3)*valores_iteracion(1, 3)) / matriz_coeficientes(1, 1);
x1_relajado = factor_relajacion * x1_nuevo + (1 - factor_relajacion) * valores_iteracion(1, 1);
fprintf('  x₁_relajado = %.6f\n\n', x1_relajado);

% Para x₂ (¡¡AQUÍ USAMOS EL NUEVO x₁ QUE ACABAMOS DE CALCULAR!!):
fprintf('Calculando x₂ (¡¡usando el NUEVO x₁!!):\n');
fprintf('  x₂_nuevo = (b₂ - a₂₁*x₁^(1) - a₂₃*x₃^(0)) / a₂₂\n');
fprintf('  x₂_nuevo = (%.1f - %.1f*%.6f - %.1f*%.1f) / %.1f\n', ...
    vector_independientes(2), matriz_coeficientes(2,1), x1_relajado, ...
    matriz_coeficientes(2,3), valores_iteracion(1, 3), matriz_coeficientes(2,2));
x2_nuevo = (vector_independientes(2) - matriz_coeficientes(2, 1)*x1_relajado - matriz_coeficientes(2, 3)*valores_iteracion(1, 3)) / matriz_coeficientes(2, 2);
x2_relajado = factor_relajacion * x2_nuevo + (1 - factor_relajacion) * valores_iteracion(1, 2);
fprintf('  x₂_relajado = %.6f\n\n', x2_relajado);

% Para x₃ (¡¡USAMOS LOS NUEVOS x₁ Y x₂!!):
fprintf('Calculando x₃ (¡¡usando los NUEVOS x₁ y x₂!!):\n');
fprintf('  x₃_nuevo = (b₃ - a₃₁*x₁^(1) - a₃₂*x₂^(1)) / a₃₃\n');
fprintf('  x₃_nuevo = (%.1f - %.1f*%.6f - %.1f*%.6f) / %.1f\n', ...
    vector_independientes(3), matriz_coeficientes(3,1), x1_relajado, ...
    matriz_coeficientes(3,2), x2_relajado, matriz_coeficientes(3,3));
x3_nuevo = (vector_independientes(3) - matriz_coeficientes(3, 1)*x1_relajado - matriz_coeficientes(3, 2)*x2_relajado) / matriz_coeficientes(3, 3);
x3_relajado = factor_relajacion * x3_nuevo + (1 - factor_relajacion) * valores_iteracion(1, 3);
fprintf('  x₃_relajado = %.6f\n\n', x3_relajado);

% Guardar valores de esta iteración
valores_iteracion(2, 1) = x1_relajado;
valores_iteracion(2, 2) = x2_relajado;
valores_iteracion(2, 3) = x3_relajado;

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
% ITERACIÓN 2 Y SUCESIVAS
% =========================================================================
% PASO 8: A partir de ahora, repetir el patrón PERO MÁS RÁPIDO
% El patrón es el mismo: usar valores recién calculados en la misma iteración
%
% Para no tener que escribir cada iteración, usa un BUCLE:

disp(' ');
disp('--- CONTINUANDO CON ITERACIONES AUTOMATIZADAS ---');
disp(' ');

for iteracion = 2:100
    % Variable temporal para guardar valores recién calculados
    valores_temp = valores_iteracion(iteracion, :);
    
    % Calcular nueva aproximación para cada variable
    for variable = 1:num_variables
        % Calcular las otras variables (índices que no sean el actual)
        otras_variables = setdiff(1:num_variables, variable);
        
        % Sumar la contribución de las otras variables
        suma = 0;
        for j = otras_variables
            suma = suma + matriz_coeficientes(variable, j) * valores_temp(j);
        end
        
        % Fórmula de Gauss-Seidel: usar valores_temp que tiene los valores 
        % recién calculados en esta iteración
        valor_nuevo = (vector_independientes(variable) - suma) / matriz_coeficientes(variable, variable);
        valores_temp(variable) = factor_relajacion * valor_nuevo + (1 - factor_relajacion) * valores_iteracion(iteracion, variable);
    end
    
    % Guardar los valores calculados en esta iteración
    valores_iteracion(iteracion + 1, :) = valores_temp;
    
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
% PASO 11: Crear tabla de resultados formateada
% =========================================================================

disp(' ');
disp('===== TABLA DE ITERACIONES =====');
disp(' ');

% Crear encabezados
fprintf('%6s %15s %15s %15s %15s %15s %15s\n', ...
    'Iter', 'x1', 'x2', 'x3', 'Error_x1(%)', 'Error_x2(%)', 'Error_x3(%)');
fprintf('%6s %15s %15s %15s %15s %15s %15s\n', ...
    '----', '---', '---', '---', '----------', '----------', '----------');

% Mostrar todas las iteraciones
for iter = 1:ultima_iteracion
    fprintf('%6d %15.8f %15.8f %15.8f %15.4f %15.4f %15.4f\n', ...
        iter-1, valores_iteracion(iter, 1), valores_iteracion(iter, 2), valores_iteracion(iter, 3), ...
        error_relativo(iter, 1), error_relativo(iter, 2), error_relativo(iter, 3));
end

% =========================================================================
% NOTAS IMPORTANTES SOBRE GAUSS-SEIDEL
% =========================================================================
% 
% • CARACTERÍSTICA CLAVE: En cada iteración, usamos los valores
%   recién calculados de las variables anteriores
%
% • Esto hace que CONVERJA MÁS RÁPIDO que Jacobi (generalmente)
%
% • El factor de relajación permite ajustar la velocidad de convergencia:
%   - factor_relajacion = 1: Gauss-Seidel puro
%   - factor_relajacion = 1.5: Sobrerrelajación (más rápido)
%   - factor_relajacion = 0.5: Subrelajación (más estable)
%
% • Si necesitas cambiar el sistema, modifica:
%   - matriz_coeficientes
%   - vector_independientes  
%   - valores_iniciales
%   - error_tolerancia
%   - factor_relajacion
%
% • Para usar la función completa GaussSeidel.m, simplemente escribe:
%   [tabla_resultados, solucion] = GaussSeidel(matriz_coeficientes, vector_independientes, valores_iniciales, [], error_tolerancia, factor_relajacion);
%   tabla_resultados
