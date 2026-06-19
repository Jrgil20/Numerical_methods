function [tabla_resultados, solucion] = GaussSeidel(matriz_coeficientes, vector_independientes, valores_iniciales, num_iteraciones_max, error_tolerancia, factor_relajacion)
%Autor: Rolando Valdez Guzmán
%Alias: Tutoingeniero
%Canal de Youtube: https://www.youtube.com/channel/UCU1pdvVscOdtLpRQBp-TbWg
%Versión: 1.2
% modificado por: ChatGPT
%Actualizado: 4/dic/2025

%DESCRIPCION: Resuelve un sistema de ecuaciones lineales usando el método de Gauss-Seidel
%con factor de relajación y pivoteo parcial.

% PARAMETROS DE ENTRADA:
%   matriz_coeficientes    = Matriz cuadrada [A] del sistema Ax = b
%   vector_independientes  = Vector columna [b] de términos independientes
%   valores_iniciales      = Vector columna con valores iniciales para cada incógnita
%   num_iteraciones_max    = Número máximo de iteraciones (dejar vacío [] si se usa error_tolerancia)
%   error_tolerancia       = Error relativo máximo permitido en % (dejar vacío [] si se usa num_iteraciones_max)
%   factor_relajacion      = Parámetro de relajación (0 a 2). Por defecto = 1 (sin cambios)

%METODOS DE SOLUCION:
%   Método 1: Si num_iteraciones_max = [] se usa error_tolerancia para converger
%   Método 2: Si error_tolerancia = [] se usa num_iteraciones_max para converger

% PARAMETROS DE SALIDA:
%   tabla_resultados = Tabla con todas las iteraciones (variables y errores relativos)
%   solucion         = Vector columna con la solución final del sistema

%~~~~~~~~~~~~~Validación y protección contra errores~~~~~~~~~~~~~~~~~~~~%
if nargin < 5                 
    error('Insuficientes datos de entrada. Se necesitan al menos 5 parámetros');
elseif nargin > 6
    error('Demasiados datos de entrada. Máximo 6 parámetros permitidos');
elseif nargin == 5
    factor_relajacion = 1;  % Por defecto, sin relajación
else
    % Validar propiedades de las matrices
    if size(matriz_coeficientes, 1) ~= size(matriz_coeficientes, 2)
        error('La matriz de coeficientes debe ser cuadrada');
    elseif size(vector_independientes, 2) ~= 1
        error('El vector de términos independientes debe ser una columna');
    elseif size(matriz_coeficientes, 1) ~= size(vector_independientes, 1)
        error('Dimensiones inconsistentes: matriz y vector tienen diferente número de filas');
    elseif size(matriz_coeficientes, 1) ~= length(valores_iniciales)
        error('Debe proporcionar un valor inicial para cada variable del sistema');
    elseif factor_relajacion < 0 || factor_relajacion > 2
        error('El factor de relajación debe estar entre 0 y 2');
    end
end

% Seleccionar método de convergencia
if isempty(num_iteraciones_max) == 1
    metodo_convergencia = 1;  % Por error
    num_iteraciones_max = 100;
    disp(newline);
    disp('>>> Resolviendo por criterio de error relativo <<<');
elseif isempty(error_tolerancia) == 1
    metodo_convergencia = 2;  % Por número de iteraciones
    disp(newline);
    disp('>>> Resolviendo por número máximo de iteraciones <<<');
elseif isempty(num_iteraciones_max) == 0 && isempty(error_tolerancia) == 0
    error('Especifique SOLO uno: num_iteraciones_max = [] O error_tolerancia = []');
end

% Verificar que la matriz no sea singular
if det(matriz_coeficientes) == 0
    error('La matriz es singular (determinante cero). Sistema sin solución única');
end

%~~~~~~~~~~~~~~~~~~~~~~~Aplicar pivoteo parcial~~~~~~~~~~~~~~~~~~~~~~~~~%
% El pivoteo parcial mejora la estabilidad numérica del método

num_variables = length(vector_independientes);

for fila_actual = 1:num_variables
    % Encontrar el elemento de mayor valor absoluto en la columna actual
    [valor_maximo, fila_max] = max(abs(matriz_coeficientes(:, fila_actual)));
    
    % Si el pivote no está en la diagonal, intercambiar filas
    if fila_actual ~= fila_max
        matriz_coeficientes([fila_actual, fila_max], :) = matriz_coeficientes([fila_max, fila_actual], :);
        vector_independientes([fila_actual, fila_max]) = vector_independientes([fila_max, fila_actual]);
    end
end

%~~~~~~~~~~~~~~~~~~~~~Algoritmo de Gauss-Seidel~~~~~~~~~~~~~~~~~~~~~~~~~%

% Inicializar variables para almacenar iteraciones
error_relativo = zeros(1, num_variables);
solucion = zeros(1, num_variables);
indices_variables = 1:num_variables;
valores_iteracion = valores_iniciales;

% Realizar iteraciones
for iteracion = 1:num_iteraciones_max - 1
    valores_anterior = valores_iteracion(iteracion, :);
    
    % Calcular nueva aproximación para cada variable
    for variable = 1:num_variables
        % Obtener índices de las otras variables
        otras_variables = indices_variables(indices_variables ~= variable);
        
        % Fórmula de Gauss-Seidel con relajación:
        % x_i^(k+1) = lambda * valor_nuevo + (1-lambda) * valor_anterior
        valor_nuevo = (vector_independientes(variable) - sum(matriz_coeficientes(variable, otras_variables) .* valores_anterior(otras_variables))) / matriz_coeficientes(variable, variable);
        valores_iteracion(iteracion + 1, variable) = factor_relajacion * valor_nuevo + (1 - factor_relajacion) * valores_iteracion(iteracion, variable);
        
        % Actualizar para la siguiente variable en la misma iteración (característica de Gauss-Seidel)
        valores_anterior(variable) = valores_iteracion(iteracion + 1, variable);
    end
    
    % Calcular error relativo aproximado para cada variable: |x_nuevo - x_anterior| / |x_nuevo|
    error_relativo(iteracion + 1, :) = abs((valores_iteracion(iteracion + 1, :) - valores_iteracion(iteracion, :)) ./ valores_iteracion(iteracion + 1, :)) * 100;
    
    % Detectar divergencia o convergencia muy lenta (después de 30 iteraciones)
    if iteracion >= 30
        if any(error_relativo(iteracion + 1, :) > error_tolerancia)
            warning('Se detectó convergencia lenta o divergencia. Intente con otros valores iniciales');
        end
    end
    
    % Criterio de parada: si el error es menor que la tolerancia
    if metodo_convergencia == 1
        if all(error_relativo(iteracion + 1, :) < error_tolerancia)
            break;  % Convergencia alcanzada
        end
    end
end

%~~~~~~~~~~~~~~~~~~~~~~~Formatear resultados~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%

% Crear encabezados de la tabla
encabezados_variables = cell(1, num_variables);
encabezados_errores = cell(1, num_variables);

for variable = 1:num_variables
    encabezados_variables(variable) = cellstr(['x' num2str(variable)]);
    encabezados_errores(variable) = cellstr(['Error_rel_x' num2str(variable) ' (%)']);
end

encabezados = [encabezados_variables, encabezados_errores];

% Combinar valores y errores para la tabla
datos_tabla = num2cell([valores_iteracion, error_relativo]);

% Obtener la solución final
solucion = valores_iteracion(end, :)';

% Crear tabla de resultados
tabla_resultados = [encabezados; datos_tabla];

end
