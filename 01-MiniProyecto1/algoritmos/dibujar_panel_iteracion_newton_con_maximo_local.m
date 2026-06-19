function dibujar_panel_iteracion_newton_con_maximo_local( ...
        total_columnas_subplot, indice_panel, ...
        funcion_objetivo, derivada_funcion_objetivo, ...
        historial_iteraciones, abscisa_maximo_local, ...
        titulo_panel)
% =========================================================================
% DIBUJAR_PANEL_ITERACION_NEWTON_CON_MAXIMO_LOCAL
% -------------------------------------------------------------------------
% Funcion auxiliar de graficacion utilizada por el Caso 3.
%
% Dibuja en el panel (1, total_columnas_subplot, indice_panel) la curva
% f(x), su derivada f'(x), el eje X, la posicion del maximo local y la
% trayectoria de iterados de Newton-Raphson (puntos rojos con tangentes
% punteadas), todo dentro del rango automatico de los iterados.
%
% PARAMETROS
%   total_columnas_subplot     : numero de columnas en el subplot.
%   indice_panel               : indice del panel a dibujar.
%   funcion_objetivo           : handle de f(x).
%   derivada_funcion_objetivo  : handle de f'(x).
%   historial_iteraciones      : matriz devuelta por
%                                metodo_newton_raphson_generico.
%   abscisa_maximo_local       : abscisa del maximo local de f para
%                                resaltarlo en el dibujo.
%   titulo_panel               : titulo del panel.
% =========================================================================

    subplot(1, total_columnas_subplot, indice_panel);
    hold on; grid on;

    limite_grafico_min_x = min([-3, min(historial_iteraciones(:, 2)) - 1]);
    limite_grafico_max_x = max([ 3, max(historial_iteraciones(:, 2)) + 1]);
    malla_dominio_grafico = linspace(limite_grafico_min_x, ...
                                     limite_grafico_max_x, 600);
    valores_funcion_en_malla   = funcion_objetivo(malla_dominio_grafico);
    valores_derivada_en_malla  = derivada_funcion_objetivo(malla_dominio_grafico);

    plot(malla_dominio_grafico, valores_funcion_en_malla, ...
         'b-', 'LineWidth', 1.8);
    plot(malla_dominio_grafico, valores_derivada_en_malla, ...
         'm-.', 'LineWidth', 1.0);
    plot(malla_dominio_grafico, zeros(size(malla_dominio_grafico)), ...
         'k-', 'LineWidth', 0.8);
    plot(abscisa_maximo_local, funcion_objetivo(abscisa_maximo_local), ...
         'k^', 'MarkerSize', 11, 'MarkerFaceColor', 'y');

    numero_filas_historial = size(historial_iteraciones, 1);
    for indice_fila = 1:numero_filas_historial
        x_k        = historial_iteraciones(indice_fila, 2);
        f_x_k      = historial_iteraciones(indice_fila, 3);
        x_k_mas_1  = historial_iteraciones(indice_fila, 5);
        plot(x_k, f_x_k, 'ro', 'MarkerSize', 7, 'MarkerFaceColor', 'r');
        text(x_k + 0.07, f_x_k + 0.18, ...
             sprintf('x_{%d}', indice_fila - 1), 'Color', 'r');
        if isfinite(x_k_mas_1) && x_k_mas_1 >= limite_grafico_min_x ...
                               && x_k_mas_1 <= limite_grafico_max_x
            plot([x_k, x_k_mas_1], [f_x_k, 0], 'r--', 'LineWidth', 0.8);
        end
    end

    xlabel('x'); ylabel('valor');
    title(titulo_panel);
    legend({'f(x)', "f'(x)", 'eje X', 'maximo local x*', ...
            'iterados x_k'}, 'Location', 'NorthWest');
end
