% =========================================================================
% MÉTODO DE GAUSS-SEIDEL - PROBLEMA COMPLETO
% =========================================================================
% Sistema de Ecuaciones Lineales:
% x1 + 10*x2 + x3 = 4
% 5*x1 + 2*x2 + x3 = 2
% x1 + x2 + 10*x3 = -1
%
% a. Determinar si es diagonal dominante
% b. Reescribir para convergencia
% c. 3 iteraciones del método con x^0 = [0; 0; 0]
% =========================================================================

clear all; close all; clc;

fprintf('\n');
fprintf('╔═══════════════════════════════════════════════════════════════════════════════╗\n');
fprintf('║                                                                               ║\n');
fprintf('║              MÉTODO DE GAUSS-SEIDEL - ANÁLISIS COMPLETO                      ║\n');
fprintf('║                                                                               ║\n');
fprintf('║  Sistema: x1 + 10*x2 + x3 = 4                                                ║\n');
fprintf('║           5*x1 + 2*x2 + x3 = 2                                               ║\n');
fprintf('║           x1 + x2 + 10*x3 = -1                                               ║\n');
fprintf('║                                                                               ║\n');
fprintf('╚═══════════════════════════════════════════════════════════════════════════════╝\n');

% =========================================================================
% PARTE A: VERIFICAR SI LA MATRIZ ES ESTRICTAMENTE DIAGONAL DOMINANTE
% =========================================================================

fprintf('\n');
fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
fprintf('PARTE A: ¿ES LA MATRIZ ESTRICTAMENTE DIAGONAL DOMINANTE?\n');
fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');

% Sistema original
A_original = [1, 10, 1;
              5, 2, 1;
              1, 1, 10];

b_original = [4; 2; -1];

fprintf('MATRIZ ORIGINAL:\n');
fprintf('A = \n');
disp(A_original);
fprintf('b = \n');
disp(b_original);

% Definición de Diagonal Dominancia Estricta:
% Para cada fila i: |a_ii| > Σ(j≠i) |a_ij|

fprintf('\nDEFINICIÓN: Una matriz es estrictamente diagonal dominante si:\n');
fprintf('  Para cada fila i: |a_ii| > Σ(j≠i) |a_ij|\n\n');

fprintf('ANÁLISIS FILA POR FILA:\n');
fprintf('─────────────────────────────────────────────────────────────────────────────\n');

n = size(A_original, 1);
es_diagonal_dominante = true;

for i = 1:n
    elemento_diagonal = abs(A_original(i, i));
    suma_otros = 0;
    
    for j = 1:n
        if i ~= j
            suma_otros = suma_otros + abs(A_original(i, j));
        end
    end
    
    fprintf('Fila %d: |a_%d%d| = |%d| = %d, Σ|a_ij| (j≠i) = |%d| + |%d| = %d\n', ...
            i, i, i, A_original(i, i), elemento_diagonal, ...
            A_original(i, 1:i-1), A_original(i, i+1:end), suma_otros);
    fprintf('        ¿%d > %d? ', elemento_diagonal, suma_otros);
    
    if elemento_diagonal > suma_otros
        fprintf('✓ SÍ\n');
    else
        fprintf('✗ NO\n');
        es_diagonal_dominante = false;
    end
end

fprintf('\n');
if es_diagonal_dominante
    fprintf('✓ LA MATRIZ ES ESTRICTAMENTE DIAGONAL DOMINANTE\n');
    fprintf('  → El método de Gauss-Seidel CONVERGE garantizado\n\n');
else
    fprintf('✗ LA MATRIZ NO ES ESTRICTAMENTE DIAGONAL DOMINANTE\n');
    fprintf('  → No se puede garantizar convergencia del método de Gauss-Seidel\n\n');
end

% =========================================================================
% PARTE B: REESCRIBIR EL SISTEMA PARA LOGRAR CONVERGENCIA
% =========================================================================

fprintf('\n');
fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
fprintf('PARTE B: REESCRIBIR SISTEMA PARA LOGRAR CONVERGENCIA\n');
fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');

if es_diagonal_dominante
    fprintf('La matriz original YA ES diagonal dominante.\n');
    fprintf('El sistema NO requiere ser reescrito.\n');
    fprintf('Usaremos el sistema original tal como está.\n\n');
    A = A_original;
    b = b_original;
else
    fprintf('Intentaremos reordenar las filas para lograr diagonal dominancia.\n\n');
    
    % Estrategia: Reordenar filas para maximizar elementos diagonales
    % Fila 1: 5*x1 + 2*x2 + x3 = 2       (diagonal = 5)
    % Fila 2: x1 + 10*x2 + x3 = 4        (diagonal = 10)
    % Fila 3: x1 + x2 + 10*x3 = -1       (diagonal = 10)
    
    fprintf('INTENTO 1: Reordenar como [Fila2, Fila1, Fila3]\n');
    fprintf('─────────────────────────────────────────────────────────────────────────────\n');
    
    A_intento1 = [5, 2, 1;
                  1, 10, 1;
                  1, 1, 10];
    
    b_intento1 = [2; 4; -1];
    
    % Verificar diagonal dominancia
    es_dd_intento1 = true;
    for i = 1:n
        elemento_diagonal = abs(A_intento1(i, i));
        suma_otros = sum(abs(A_intento1(i, :))) - elemento_diagonal;
        
        fprintf('Fila %d: |%d| > %d? ', i, elemento_diagonal, suma_otros);
        if elemento_diagonal > suma_otros
            fprintf('✓\n');
        else
            fprintf('✗\n');
            es_dd_intento1 = false;
        end
    end
    
    if es_dd_intento1
        fprintf('\n✓ Sistema reordenado es diagonal dominante:\n');
        A = A_intento1;
        b = b_intento1;
        fprintf('Sistema reordenado:\n');
        fprintf('5*x1 + 2*x2 + x3 = 2\n');
        fprintf('x1 + 10*x2 + x3 = 4\n');
        fprintf('x1 + x2 + 10*x3 = -1\n');
    else
        fprintf('\n✗ Intento 1 no es diagonal dominante.\n');
        fprintf('Usando el sistema original de todas formas...\n');
        A = A_original;
        b = b_original;
    end
end

% =========================================================================
% PARTE C: TRES ITERACIONES DEL MÉTODO DE GAUSS-SEIDEL
% =========================================================================

fprintf('\n\n');
fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
fprintf('PARTE C: TRES ITERACIONES DEL MÉTODO DE GAUSS-SEIDEL\n');
fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');

fprintf('FÓRMULA DE GAUSS-SEIDEL:\n');
fprintf('─────────────────────────────────────────────────────────────────────────────\n');
fprintf('x_i^(k) = (b_i - Σ(j<i) a_ij * x_j^(k) - Σ(j>i) a_ij * x_j^(k-1)) / a_ii\n\n');

fprintf('INTERPRETACIÓN:\n');
fprintf('• Usa valores ACTUALIZADOS (de iteración k) para j < i\n');
fprintf('• Usa valores ANTERIORES (de iteración k-1) para j > i\n\n');

% Estado inicial
x = [0; 0; 0];
n = length(b);
num_iteraciones = 3;

fprintf('Vector inicial: x^0 = [0; 0; 0]^T\n\n');

% Almacenar historial
historial = zeros(num_iteraciones + 1, n);
historial(1, :) = x';

% Realizar iteraciones
for k = 1:num_iteraciones
    fprintf('╔═════════════════════════════════════════════════════════════════════════════╗\n');
    fprintf('║ ITERACIÓN %d                                                               ║\n', k);
    fprintf('╚═════════════════════════════════════════════════════════════════════════════╝\n\n');
    
    x_prev = x;  % Guardar x^(k-1) para usar en componentes posteriores
    
    % Cálculo de cada componente
    for i = 1:n
        % Sumar términos con j < i (usando valores actualizados x^(k))
        suma_anterior = 0;
        for j = 1:(i-1)
            suma_anterior = suma_anterior + A(i, j) * x(j);
        end
        
        % Sumar términos con j > i (usando valores anteriores x^(k-1))
        suma_posterior = 0;
        for j = (i+1):n
            suma_posterior = suma_posterior + A(i, j) * x_prev(j);
        end
        
        % Mostrar cálculo detallado
        fprintf('x_%d^(%d) = (b_%d - (suma términos j<i) - (suma términos j>i)) / a_%d%d\n', ...
                i, k, i, i, i);
        
        % Mostrar términos j < i
        if i > 1
            fprintf('         = (%d - (', b(i));
            for j = 1:(i-1)
                if j == 1
                    fprintf('%d·%.6f', A(i, j), x(j));
                else
                    fprintf(' + %d·%.6f', A(i, j), x(j));
                end
            end
            fprintf(') ', suma_anterior);
        else
            fprintf('         = (%d ', b(i));
        end
        
        % Mostrar términos j > i
        if i < n
            fprintf('- (');
            for j = (i+1):n
                if j == i+1
                    fprintf('%d·%.6f', A(i, j), x_prev(j));
                else
                    fprintf(' + %d·%.6f', A(i, j), x_prev(j));
                end
            end
            fprintf(')) / %d\n', A(i, i));
        else
            fprintf(') / %d\n', A(i, i));
        end
        
        % Calcular valor
        x(i) = (b(i) - suma_anterior - suma_posterior) / A(i, i);
        
        fprintf('         = (%.6f - %.6f - %.6f) / %d\n', b(i), suma_anterior, suma_posterior, A(i, i));
        fprintf('         = %.6f / %d\n', b(i) - suma_anterior - suma_posterior, A(i, i));
        fprintf('         = %.6f\n\n', x(i));
    end
    
    % Guardar iteración
    historial(k+1, :) = x';
    
    fprintf('Vector actualizado: x^(%d) = [%.6f; %.6f; %.6f]^T\n\n', k, x(1), x(2), x(3));
end

% =========================================================================
% TABLA RESUMEN DE ITERACIONES
% =========================================================================

fprintf('\n');
fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
fprintf('RESUMEN DE LAS 3 ITERACIONES\n');
fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');

fprintf('┌────────┬──────────────────┬──────────────────┬──────────────────┐\n');
fprintf('│  k    │       x1         │       x2         │       x3         │\n');
fprintf('├────────┼──────────────────┼──────────────────┼──────────────────┤\n');

for k = 0:num_iteraciones
    fprintf('│  %d    │   %12.8f   │   %12.8f   │   %12.8f   │\n', ...
            k, historial(k+1, 1), historial(k+1, 2), historial(k+1, 3));
end

fprintf('└────────┴──────────────────┴──────────────────┴──────────────────┘\n\n');

% =========================================================================
% VERIFICACIÓN: COMPROBAR CONVERGENCIA TEÓRICA
% =========================================================================

fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
fprintf('ANÁLISIS DE CONVERGENCIA\n');
fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');

% Calcular matriz de iteración
fprintf('Matriz de iteración D (diagonal) y L (triangular inferior sin diagonal):\n');
D = diag(diag(A));
L = -tril(A, -1);
U = -triu(A, 1);

fprintf('D = \n');
disp(D);

fprintf('L = \n');
disp(L);

fprintf('U = \n');
disp(U);

% Radio espectral
M_gs = (D - L) \ U;  % Matriz de iteración de Gauss-Seidel
eigenvalues_gs = eig(M_gs);
radio_espectral_gs = max(abs(eigenvalues_gs));

fprintf('\nMatriz de iteración M = (D - L)^(-1) * U:\n');
disp(M_gs);

fprintf('\nAutovalores de M: \n');
fprintf('  λ1 = %.6f\n', eigenvalues_gs(1));
fprintf('  λ2 = %.6f\n', eigenvalues_gs(2));
fprintf('  λ3 = %.6f\n', eigenvalues_gs(3));

fprintf('\nRadio espectral ρ(M) = max|λ_i| = %.6f\n', radio_espectral_gs);

if radio_espectral_gs < 1
    fprintf('✓ ρ(M) < 1 → Método CONVERGE garantizado\n');
else
    fprintf('✗ ρ(M) ≥ 1 → Método puede NO converger\n');
end

% =========================================================================
% CONCLUSIÓN
% =========================================================================

fprintf('\n');
fprintf('═══════════════════════════════════════════════════════════════════════════════\n');
fprintf('CONCLUSIÓN\n');
fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');

fprintf('a) Diagonal Dominancia: ');
if es_diagonal_dominante
    fprintf('✓ SÍ (aunque puede requerirse reordenamiento)\n\n');
else
    fprintf('✗ NO en el orden original\n\n');
end

fprintf('b) Sistema para convergencia:\n');
if es_diagonal_dominante
    fprintf('   Sistema ORIGINAL es diagonal dominante (o reordenado arriba)\n\n');
else
    fprintf('   Sistema debe ser REORDENADO como se mostró en Parte B\n\n');
end

fprintf('c) Resultados de 3 iteraciones:\n');
fprintf('   x^0 = [%.6f; %.6f; %.6f]^T\n', historial(1, 1), historial(1, 2), historial(1, 3));
fprintf('   x^1 = [%.6f; %.6f; %.6f]^T\n', historial(2, 1), historial(2, 2), historial(2, 3));
fprintf('   x^2 = [%.6f; %.6f; %.6f]^T\n', historial(3, 1), historial(3, 2), historial(3, 3));
fprintf('   x^3 = [%.6f; %.6f; %.6f]^T\n\n', historial(4, 1), historial(4, 2), historial(4, 3));

fprintf('Convergencia teórica: ');
fprintf('ρ(M) = %.6f (< 1 → CONVERGE)\n\n', radio_espectral_gs);

fprintf('═══════════════════════════════════════════════════════════════════════════════\n\n');
