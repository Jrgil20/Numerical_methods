% =========================================================================
% CASO 1: BUCLE INFINITO DE LA FUNCION CUBICA MODIFICADA
% -------------------------------------------------------------------------
% Funcion analizada:
%       f(x) = x^3 - 5x
%       f'(x) = 3x^2 - 5
%
% Raices reales: x = -sqrt(5), x = 0, x = sqrt(5).
%
% --------------------------- DEMOSTRACION ANALITICA ----------------------
% Aplicando Newton-Raphson con x_0 = 1 obtenemos:
%
%   f(1)  = 1 - 5     = -4
%   f'(1) = 3 - 5     = -2
%   x_1   = 1 - (-4)/(-2) = 1 - 2 = -1
%
%   f(-1)  = -1 + 5   =  4
%   f'(-1) = 3 - 5    = -2
%   x_2    = -1 - (4)/(-2) = -1 + 2 = 1
%
% El iterado regresa exactamente a x_0. La sucesion forma el CICLO LIMITE
% de periodo 2:    1 -> -1 -> 1 -> -1 -> ...
% El metodo NUNCA convergera a ninguna de las tres raices con x_0 = 1.
% =========================================================================

clc;
close all;

% -------------------------------------------------------------------------
% Parametros del experimento numerico.
% -------------------------------------------------------------------------
funcion_objetivo                  = @(x) x.^3 - 5.*x;
derivada_funcion_objetivo         = @(x) 3.*x.^2 - 5;
valor_inicial_x0                  = 1;
tolerancia_error_absoluto         = 1e-8;
maximo_numero_iteraciones         = 20;

printf('=========================================================\n');
printf('  CASO 1: f(x) = x^3 - 5x   |   x_0 = %g\n', valor_inicial_x0);
printf('  Resultado esperado: ciclo limite de periodo 2 entre 1 y -1\n');
printf('=========================================================\n');

[raiz_aproximada, historial_iteraciones, estado_convergencia] = ...
    metodo_newton_raphson_generico( ...
        funcion_objetivo, derivada_funcion_objetivo, ...
        valor_inicial_x0, tolerancia_error_absoluto, ...
        maximo_numero_iteraciones);

printf('\nEstado final del metodo : %s\n', estado_convergencia);
printf('Ultima aproximacion x_k : %.10f\n', raiz_aproximada);

% -------------------------------------------------------------------------
% Construccion de la grafica:
%   1) f(x) en un rango que contenga las raices reales y el ciclo.
%   2) Sucesion de iterados sobre la curva (x_k, f(x_k)).
%   3) "Telarana" de Newton (rectas tangentes desde cada x_k).
% -------------------------------------------------------------------------
malla_dominio_grafico             = linspace(-3, 3, 400);
valores_funcion_en_malla          = funcion_objetivo(malla_dominio_grafico);

figura_caso_1 = figure('Name', 'Caso 1 - Ciclo limite Newton-Raphson', ...
                       'Position', [100 100 900 600], ...
                       'Visible', 'off');
hold on; grid on;
plot(malla_dominio_grafico, valores_funcion_en_malla, ...
     'b-', 'LineWidth', 1.8);
plot(malla_dominio_grafico, zeros(size(malla_dominio_grafico)), ...
     'k-', 'LineWidth', 0.8);

% Marcar las tres raices reales analiticas.
raices_analiticas_funcion         = [-sqrt(5), 0, sqrt(5)];
plot(raices_analiticas_funcion, zeros(1, 3), ...
     'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');

% Trazar las rectas tangentes y los iterados sucesivos.
numero_filas_historial = size(historial_iteraciones, 1);
for indice_fila = 1:numero_filas_historial
    x_k        = historial_iteraciones(indice_fila, 2);
    f_x_k      = historial_iteraciones(indice_fila, 3);
    df_x_k     = historial_iteraciones(indice_fila, 4);
    x_k_mas_1  = historial_iteraciones(indice_fila, 5);

    plot(x_k, f_x_k, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
    text(x_k + 0.05, f_x_k + 0.3, sprintf('x_{%d}', indice_fila - 1), ...
         'Color', 'r', 'FontSize', 9);

    if isfinite(x_k_mas_1)
        % Recta tangente: y - f(x_k) = f'(x_k)*(x - x_k); cruce con eje X.
        coordenadas_x_tangente = [x_k, x_k_mas_1];
        coordenadas_y_tangente = [f_x_k, 0];
        plot(coordenadas_x_tangente, coordenadas_y_tangente, ...
             'r--', 'LineWidth', 0.8);
        plot([x_k_mas_1, x_k_mas_1], [0, funcion_objetivo(x_k_mas_1)], ...
             'r:', 'LineWidth', 0.8);
    end
end

xlabel('x');
ylabel('f(x) = x^3 - 5x');
title({'Caso 1: Ciclo limite del metodo de Newton-Raphson', ...
       sprintf('x_0 = %g  ->  oscila entre 1 y -1 (estado: %s)', ...
               valor_inicial_x0, ...
               strrep(estado_convergencia, '_', ' '))});
legend({'f(x)', 'eje X', 'raices analiticas', ...
        'iterados x_k', 'rectas tangentes'}, 'Location', 'NorthWest');
axis([-3 3 -10 10]);

ruta_imagen_salida = fullfile(fileparts(mfilename('fullpath')), ...
    'salida_grafica_caso1_ciclo_limite_funcion_cubica.png');
print(figura_caso_1, ruta_imagen_salida, '-dpng', '-r150');
printf('\nGrafica guardada en: %s\n', ruta_imagen_salida);
close(figura_caso_1);
