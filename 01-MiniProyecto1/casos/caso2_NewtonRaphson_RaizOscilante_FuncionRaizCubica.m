% =========================================================================
% CASO 2: PROBLEMA DE LA RAIZ OSCILANTE (RAIZ CUBICA)
% -------------------------------------------------------------------------
% Funcion analizada:
%       f(x)  = x^(1/3)         (raiz cubica real, definida para todo x)
%       f'(x) = (1/3) * x^(-2/3)
%
% Unica raiz real: x = 0.
%
% --------------------------- DEMOSTRACION ANALITICA ----------------------
% La iteracion de Newton-Raphson aplicada a esta funcion produce:
%
%   x_{k+1} = x_k - f(x_k)/f'(x_k)
%           = x_k - x_k^(1/3) / [(1/3) * x_k^(-2/3)]
%           = x_k - 3 * x_k^(1/3) * x_k^(2/3)
%           = x_k - 3 * x_k
%           = -2 * x_k
%
% Por lo tanto, para cualquier x_0 != 0 la sucesion satisface
%       |x_{k+1}| = 2 * |x_k|,
% y los iterados crecen geometricamente en magnitud, oscilando ademas
% en signo. El metodo NUNCA puede converger a la raiz x = 0 si se parte
% de un valor distinto de cero.
%
% Geometricamente: la tangente en x_k corta al eje X en -2*x_k, alejandose
% sistematicamente de la raiz. Esta es una falla por raiz de "tipo no
% suave" (la derivada explota en x = 0).
% =========================================================================

clc;
close all;

ruta_carpeta_actual = fileparts(mfilename('fullpath'));
addpath(fullfile(ruta_carpeta_actual, '..', 'algoritmos'));

% -------------------------------------------------------------------------
% Para que f(x) = x^(1/3) este definida para x negativos en Octave/Matlab,
% NO se puede usar x.^(1/3) directamente (devuelve numeros complejos para
% x < 0). Empleamos una version "real" usando sign(x) y |x|.
% -------------------------------------------------------------------------
funcion_raiz_cubica_real          = @(x) sign(x) .* abs(x).^(1/3);
derivada_raiz_cubica_real         = @(x) (1/3) .* abs(x).^(-2/3);

valor_inicial_x0                  = 0.5;
tolerancia_error_absoluto         = 1e-8;
maximo_numero_iteraciones         = 12;
umbral_minimo_derivada            = 1e-15;
umbral_maximo_magnitud_iterado    = 1e10;

printf('=========================================================\n');
printf('  CASO 2: f(x) = x^(1/3)   |   x_0 = %g\n', valor_inicial_x0);
printf('  Resultado esperado: divergencia, |x_{k+1}| = 2 * |x_k|\n');
printf('=========================================================\n');

[raiz_aproximada, historial_iteraciones, estado_convergencia] = ...
    metodo_newton_raphson_generico( ...
        funcion_raiz_cubica_real, derivada_raiz_cubica_real, ...
        valor_inicial_x0, tolerancia_error_absoluto, ...
        maximo_numero_iteraciones, umbral_minimo_derivada, ...
        umbral_maximo_magnitud_iterado);

printf('\nEstado final del metodo : %s\n', estado_convergencia);
printf('Ultima aproximacion x_k : %.10g\n', raiz_aproximada);

% -------------------------------------------------------------------------
% Visualizacion: dos paneles.
%   (a) f(x) y los iterados sobre la curva, con sus tangentes.
%   (b) |x_k| en escala logaritmica para evidenciar el crecimiento
%       geometrico con razon 2.
% -------------------------------------------------------------------------
limite_grafico = max(abs(historial_iteraciones(:, 2))) * 1.2;
if limite_grafico < 2
    limite_grafico = 2;
end
malla_dominio_grafico             = linspace(-limite_grafico, limite_grafico, 400);
valores_funcion_en_malla          = funcion_raiz_cubica_real(malla_dominio_grafico);

figura_caso_2 = figure('Name', 'Caso 2 - Raiz oscilante cubica', ...
                       'Position', [100 100 1100 500], ...
                       'Visible', 'off');

% --- Panel A ----------------------------------------------------------
subplot(1, 2, 1);
hold on; grid on;
plot(malla_dominio_grafico, valores_funcion_en_malla, ...
     'b-', 'LineWidth', 1.8);
plot(malla_dominio_grafico, zeros(size(malla_dominio_grafico)), ...
     'k-', 'LineWidth', 0.8);
plot(0, 0, 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');

numero_filas_historial = size(historial_iteraciones, 1);
for indice_fila = 1:numero_filas_historial
    x_k        = historial_iteraciones(indice_fila, 2);
    f_x_k      = historial_iteraciones(indice_fila, 3);
    x_k_mas_1  = historial_iteraciones(indice_fila, 5);
    plot(x_k, f_x_k, 'ro', 'MarkerSize', 7, 'MarkerFaceColor', 'r');
    if isfinite(x_k_mas_1) && abs(x_k_mas_1) <= limite_grafico
        plot([x_k, x_k_mas_1], [f_x_k, 0], 'r--', 'LineWidth', 0.8);
        plot([x_k_mas_1, x_k_mas_1], ...
             [0, funcion_raiz_cubica_real(x_k_mas_1)], ...
             'r:', 'LineWidth', 0.8);
    end
end
xlabel('x'); ylabel('f(x) = x^{1/3}');
title('Iterados de Newton-Raphson sobre f(x) = x^{1/3}');
legend({'f(x)', 'eje X', 'raiz x=0', 'iterados', 'tangentes'}, ...
       'Location', 'NorthWest');

% --- Panel B ----------------------------------------------------------
subplot(1, 2, 2);
indices_iteraciones_grafico = historial_iteraciones(:, 1);
magnitudes_iterados         = abs(historial_iteraciones(:, 2));
semilogy(indices_iteraciones_grafico, magnitudes_iterados, ...
         'ro-', 'LineWidth', 1.5, 'MarkerFaceColor', 'r');
hold on; grid on;
prediccion_teorica_geometrica = abs(valor_inicial_x0) ...
                              * 2 .^ indices_iteraciones_grafico;
semilogy(indices_iteraciones_grafico, prediccion_teorica_geometrica, ...
         'b--', 'LineWidth', 1.2);
xlabel('iteracion k'); ylabel('|x_k|  (escala log)');
title('Crecimiento geometrico: |x_k| = |x_0| * 2^k');
legend({'experimental', 'teorico  |x_0| 2^k'}, 'Location', 'NorthWest');

ruta_imagen_salida = fullfile(fileparts(mfilename('fullpath')), ...
    '..', 'salidas', ...
    'salida_grafica_caso2_raiz_oscilante_cubica.png');
print(figura_caso_2, ruta_imagen_salida, '-dpng', '-r150');
printf('\nGrafica guardada en: %s\n', ruta_imagen_salida);
close(figura_caso_2);
