% =========================================================================
% CASO 4: TRAMPA DE LA RAIZ OMITIDA (BISECCION SOBRE POLINOMIO PERTURBADO)
% -------------------------------------------------------------------------
% Funcion analizada:
%       f(x) = (x - 1.1)^2 * (x - 2) - 0.01
%
% La funcion sin perturbar  g(x) = (x - 1.1)^2 * (x - 2)  posee una raiz
% DOBLE en x = 1.1 (que es tangente al eje X) y una raiz SIMPLE en x = 2.
% Al introducir el termino  -0.01  se rompe la tangencia y se obtiene
% una funcion que, segun el signo y magnitud de la perturbacion, puede:
%
%   * generar tres raices reales muy cercanas entre si en torno a 1.1, o
%   * eliminar (esconder) las raices proximas a 1.1, dejando una unica
%     raiz simple cerca de 2.
%
% Para  -0.01  ocurre el segundo caso: f(x) queda permanentemente debajo
% del eje X en una vecindad amplia de x = 1.1 (con minimo cerca de
% x = 1.7) y solo cruza el eje una vez, cerca de x ~ 2.0083.
%
% --------------------------- COMPROBACION DE BOLZANO --------------------
%   f(1) = (1 - 1.1)^2 * (1 - 2) - 0.01 = 0.01 * (-1) - 0.01 = -0.02
%   f(3) = (3 - 1.1)^2 * (3 - 2) - 0.01 = 3.61          - 0.01 =  3.60
%   f(1) * f(3) = -0.072 < 0   =>   se cumple cambio de signo en [1, 3].
%
% La biseccion converge hasta la unica raiz contenida en el intervalo,
% pero el "diseno" del problema esconde una zona en la que  f(x) ~ -0.01
% (alrededor de x = 1.1 y x = 2). El metodo de Biseccion es CIEGO ante
% esas casi-raices: no las detecta, no las informa, y por tanto el
% modelador puede pasar por alto comportamientos fisicamente relevantes
% (sistemas con casi-resonancia, multiplicidad escondida, etc.).
% =========================================================================

clc;
close all;

funcion_objetivo                 = @(x) (x - 1.1).^2 .* (x - 2) - 0.01;

extremo_inferior_intervalo_a     = 1;
extremo_superior_intervalo_b     = 3;
tolerancia_error_absoluto        = 1e-6;
maximo_numero_iteraciones        = 50;

% --- Verificacion explicita de la condicion de Bolzano -------------------
valor_funcion_en_a = funcion_objetivo(extremo_inferior_intervalo_a);
valor_funcion_en_b = funcion_objetivo(extremo_superior_intervalo_b);
printf('=========================================================\n');
printf('  CASO 4: f(x) = (x-1.1)^2 (x-2) - 0.01\n');
printf('  Intervalo [%g, %g]\n', extremo_inferior_intervalo_a, ...
                                 extremo_superior_intervalo_b);
printf('  f(a) = %.6f   f(b) = %.6f   f(a)*f(b) = %.6f\n', ...
       valor_funcion_en_a, valor_funcion_en_b, ...
       valor_funcion_en_a * valor_funcion_en_b);
if valor_funcion_en_a * valor_funcion_en_b < 0
    printf('  Cambio de signo: SI se cumple (Bolzano OK).\n');
else
    printf('  Cambio de signo: NO se cumple.\n');
end
printf('=========================================================\n');

[raiz_aproximada, historial_iteraciones, estado_convergencia] = ...
    metodo_biseccion_generico( ...
        funcion_objetivo, extremo_inferior_intervalo_a, ...
        extremo_superior_intervalo_b, tolerancia_error_absoluto, ...
        maximo_numero_iteraciones);

printf('\nEstado final del metodo : %s\n', estado_convergencia);
printf('Raiz aproximada calculada por biseccion : %.8f\n', raiz_aproximada);

% -------------------------------------------------------------------------
% Visualizacion: dos paneles.
%  (a) f(x) en [0.5, 3.2] con la zona "cuasi-cero" sombreada y los
%      sucesivos puntos medios c_k del proceso de biseccion.
%  (b) Decrecimiento del error (b_k - a_k)/2 frente a la iteracion k.
% -------------------------------------------------------------------------
malla_dominio_grafico             = linspace(0.5, 3.2, 800);
valores_funcion_en_malla          = funcion_objetivo(malla_dominio_grafico);

figura_caso_4 = figure('Name', 'Caso 4 - Biseccion: raiz omitida', ...
                       'Position', [100 100 1200 500], ...
                       'Visible', 'off');

subplot(1, 2, 1);
hold on; grid on;
plot(malla_dominio_grafico, valores_funcion_en_malla, ...
     'b-', 'LineWidth', 1.8);
plot(malla_dominio_grafico, zeros(size(malla_dominio_grafico)), ...
     'k-', 'LineWidth', 0.8);

% Zona sombreada en torno a x=1.1: ahi la funcion se acerca al eje
% pero NO lo cruza, por lo que biseccion no puede detectarla.
banda_inferior_zona_cuasi_cero = 0.9;
banda_superior_zona_cuasi_cero = 1.4;
indices_dentro_de_banda = (malla_dominio_grafico >= banda_inferior_zona_cuasi_cero) & ...
                          (malla_dominio_grafico <= banda_superior_zona_cuasi_cero);
fill([malla_dominio_grafico(indices_dentro_de_banda), ...
      fliplr(malla_dominio_grafico(indices_dentro_de_banda))], ...
     [valores_funcion_en_malla(indices_dentro_de_banda), ...
      zeros(1, sum(indices_dentro_de_banda))], ...
     [1.0 0.85 0.85], 'EdgeColor', 'none');
plot(malla_dominio_grafico, valores_funcion_en_malla, ...
     'b-', 'LineWidth', 1.8);
plot(malla_dominio_grafico, zeros(size(malla_dominio_grafico)), ...
     'k-', 'LineWidth', 0.8);

% Marcar la unica raiz que SI encuentra biseccion.
plot(raiz_aproximada, 0, 'go', 'MarkerSize', 11, 'MarkerFaceColor', 'g');

% Trazar los puntos medios c_k.
puntos_medios_biseccion = historial_iteraciones(:, 4);
valores_funcion_en_puntos_medios = historial_iteraciones(:, 7);
plot(puntos_medios_biseccion, valores_funcion_en_puntos_medios, ...
     'r.', 'MarkerSize', 8);

% Marcar las "casi-raices" (los dos puntos donde f(x) toca su minimo
% relativo cercano a -0.01 -- vienen de la perturbacion).
abscisa_casi_raiz_izquierda = 1.1;
abscisa_casi_raiz_derecha   = 2.0;
plot(abscisa_casi_raiz_izquierda, ...
     funcion_objetivo(abscisa_casi_raiz_izquierda), ...
     'k*', 'MarkerSize', 11, 'LineWidth', 1.5);
plot(abscisa_casi_raiz_derecha, ...
     funcion_objetivo(abscisa_casi_raiz_derecha), ...
     'k*', 'MarkerSize', 11, 'LineWidth', 1.5);

xlabel('x'); ylabel('f(x)');
title({'Biseccion encuentra solo la raiz cercana a 2.008', ...
       'pero ignora la zona f(x) ~ -0.01 alrededor de 1.1'});
legend({'f(x)', 'eje X', 'zona "casi-raiz" oculta', ...
        'raiz hallada', 'puntos medios c_k', 'casi-raices'}, ...
       'Location', 'NorthWest');
axis([0.5 3.2 -0.4 1.0]);

subplot(1, 2, 2);
indices_iteraciones_grafico = historial_iteraciones(:, 1);
errores_absolutos_iteracion = historial_iteraciones(:, 8);
semilogy(indices_iteraciones_grafico, errores_absolutos_iteracion, ...
         'bo-', 'LineWidth', 1.4, 'MarkerFaceColor', 'b');
hold on; grid on;
xlabel('iteracion k'); ylabel('error_k = (b_k - a_k)/2');
title('Decrecimiento geometrico del error por biseccion');

ruta_imagen_salida = fullfile(fileparts(mfilename('fullpath')), ...
    'salida_grafica_caso4_biseccion_raiz_omitida.png');
print(figura_caso_4, ruta_imagen_salida, '-dpng', '-r150');
printf('\nGrafica guardada en: %s\n', ruta_imagen_salida);
close(figura_caso_4);

% -------------------------------------------------------------------------
% Diagnostico explicativo final del fallo "de diseno":
% -------------------------------------------------------------------------
printf('\n');
printf('--- DIAGNOSTICO DEL FALLO DE DISENO -----------------------------\n');
printf('La biseccion confirma UNA raiz cerca de %.6f con error <= %g.\n', ...
       raiz_aproximada, tolerancia_error_absoluto);
printf('Sin embargo, en el intervalo [0.9, 1.4] la funcion f(x) toma\n');
printf('valores cercanos a -0.01: si la perturbacion fuese ligeramente\n');
printf('distinta (por ejemplo +0.01 en lugar de -0.01) apareceria un\n');
printf('par adicional de raices reales en torno a x = 1.1. La biseccion\n');
printf('NO observa estas "casi-raices" porque solo reacciona a cambios\n');
printf('de signo: pierde por completo la informacion fisica de un\n');
printf('sistema cercano a la multiplicidad / casi-resonancia.\n');
