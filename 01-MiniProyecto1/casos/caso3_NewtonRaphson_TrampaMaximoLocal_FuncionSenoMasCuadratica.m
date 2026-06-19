% =========================================================================
% CASO 3: TRAMPA DEL MAXIMO LOCAL (FUNCION sin(x) + x^2/20)
% -------------------------------------------------------------------------
% Funcion analizada:
%       f(x)  = sin(x) + x^2 / 20
%       f'(x) = cos(x) + x / 10
%
% Esta funcion presenta UN MAXIMO LOCAL en el intervalo (1, pi/2) cuya
% abscisa x* satisface  cos(x*) + x*/10 = 0. Numericamente:
%       x*_max_local approx 1.74633   con   f(x*_max_local) approx 1.137.
%
% --------------------------- DEMOSTRACION ANALITICA ----------------------
% Cuando el iterado x_k se aproxima a x*_max_local, la derivada f'(x_k)
% tiende a 0, por lo que la correccion de Newton:
%
%       Delta_k = - f(x_k) / f'(x_k)
%
% se hace ARBITRARIAMENTE GRANDE en magnitud y arroja al iterado
% siguiente x_{k+1} muy lejos del intervalo de interes; este es el
% "colapso por maximo local".
%
% --------------------------- DOS SUB-EXPERIMENTOS ------------------------
% Sub-experimento 3A: punto inicial literal del enunciado, x_0 = 1.08216.
% Sub-experimento 3B: punto inicial cercano al maximo local x_0 = 1.7,
%                     elegido para ver el colapso de manera contundente.
%
% Se incluyen los DOS para ofrecer una vision completa: el primero
% evidencia la inestabilidad en forma de "salto violento" (la primera
% iteracion lanza al iterado de 1.08216 a aproximadamente -0.55, muy
% lejos de la zona inicial) aunque, por casualidad, la dinamica
% posterior recupera la convergencia hacia x = 0; el segundo confirma
% la falla "de libro de texto" (division por una derivada casi nula).
% =========================================================================

clc;
close all;

ruta_carpeta_actual = fileparts(mfilename('fullpath'));
addpath(fullfile(ruta_carpeta_actual, '..', 'algoritmos'));

funcion_objetivo                  = @(x) sin(x) + x.^2 / 20;
derivada_funcion_objetivo         = @(x) cos(x) + x / 10;

tolerancia_error_absoluto         = 1e-8;
maximo_numero_iteraciones         = 15;
umbral_minimo_derivada            = 1e-6;
umbral_maximo_magnitud_iterado    = 1e6;

% -------------------------------------------------------------------------
% Localizacion numerica del maximo local (sirve de referencia visual y
% comprueba la teoria). Se busca el cero de f'(x) en el intervalo [1, 2]
% mediante una busqueda incremental simple seguida por interpolacion
% lineal en el intervalo donde se detecte el cambio de signo.
% -------------------------------------------------------------------------
malla_busqueda_max_local          = linspace(1, 2, 20001);
valores_derivada_en_malla         = derivada_funcion_objetivo(malla_busqueda_max_local);
indice_cambio_signo               = find(diff(sign(valores_derivada_en_malla)) ~= 0, 1);
abscisa_maximo_local              = malla_busqueda_max_local(indice_cambio_signo) + ...
    (malla_busqueda_max_local(indice_cambio_signo + 1) ...
   - malla_busqueda_max_local(indice_cambio_signo)) ...
   * abs(valores_derivada_en_malla(indice_cambio_signo)) ...
   / (abs(valores_derivada_en_malla(indice_cambio_signo)) ...
    + abs(valores_derivada_en_malla(indice_cambio_signo + 1)));

printf('=========================================================\n');
printf('  CASO 3: f(x) = sin(x) + x^2/20\n');
printf('  Maximo local detectado en x* ~ %.6f  (f(x*) ~ %.6f)\n', ...
       abscisa_maximo_local, funcion_objetivo(abscisa_maximo_local));
printf('=========================================================\n');

% =====================================================================
% SUB-EXPERIMENTO 3A: x_0 = 1.08216 (literal del enunciado)
% =====================================================================
valor_inicial_x0_caso_literal     = 1.08216;
printf('\n--- Sub-experimento 3A: x_0 = %g (literal del enunciado) ---\n', ...
       valor_inicial_x0_caso_literal);

[raiz_aproximada_3A, historial_iteraciones_3A, estado_convergencia_3A] = ...
    metodo_newton_raphson_generico( ...
        funcion_objetivo, derivada_funcion_objetivo, ...
        valor_inicial_x0_caso_literal, tolerancia_error_absoluto, ...
        maximo_numero_iteraciones, umbral_minimo_derivada, ...
        umbral_maximo_magnitud_iterado);
printf('Estado final 3A : %s\n', estado_convergencia_3A);
printf('Ultima x_k 3A   : %.10g\n', raiz_aproximada_3A);
printf('Observacion: el primer paso lanza el iterado de %.4f a %.4f,\n', ...
       historial_iteraciones_3A(1, 2), historial_iteraciones_3A(1, 5));
printf('un salto de magnitud %.4f que evidencia la fragilidad de\n', ...
       abs(historial_iteraciones_3A(1, 5) - historial_iteraciones_3A(1, 2)));
printf('Newton-Raphson cerca del maximo local x* ~ %.4f.\n', ...
       abscisa_maximo_local);

% =====================================================================
% SUB-EXPERIMENTO 3B: x_0 = 1.7 (proximo al maximo local)
% =====================================================================
valor_inicial_x0_caso_critico     = 1.7;
printf('\n--- Sub-experimento 3B: x_0 = %g (cerca del maximo local) ---\n', ...
       valor_inicial_x0_caso_critico);

[raiz_aproximada_3B, historial_iteraciones_3B, estado_convergencia_3B] = ...
    metodo_newton_raphson_generico( ...
        funcion_objetivo, derivada_funcion_objetivo, ...
        valor_inicial_x0_caso_critico, tolerancia_error_absoluto, ...
        maximo_numero_iteraciones, umbral_minimo_derivada, ...
        umbral_maximo_magnitud_iterado);
printf('Estado final 3B : %s\n', estado_convergencia_3B);
printf('Ultima x_k 3B   : %.10g\n', raiz_aproximada_3B);

% -------------------------------------------------------------------------
% Visualizacion: dos paneles, uno por cada sub-experimento, con la
% funcion, sus tangentes y la posicion del maximo local resaltada.
% -------------------------------------------------------------------------
figura_caso_3 = figure('Name', 'Caso 3 - Trampa del maximo local', ...
                       'Position', [100 100 1400 600], ...
                       'Visible', 'off');

dibujar_panel_iteracion_newton_con_maximo_local( ...
    2, 1, ...
    funcion_objetivo, derivada_funcion_objetivo, ...
    historial_iteraciones_3A, abscisa_maximo_local, ...
    sprintf('3A: x_0=%.5f -> %s', ...
            valor_inicial_x0_caso_literal, ...
            strrep(estado_convergencia_3A, '_', ' ')));

dibujar_panel_iteracion_newton_con_maximo_local( ...
    2, 2, ...
    funcion_objetivo, derivada_funcion_objetivo, ...
    historial_iteraciones_3B, abscisa_maximo_local, ...
    sprintf('3B: x_0=%.5f -> %s', ...
            valor_inicial_x0_caso_critico, ...
            strrep(estado_convergencia_3B, '_', ' ')));

ruta_imagen_salida = fullfile(fileparts(mfilename('fullpath')), ...
    '..', 'salidas', ...
    'salida_grafica_caso3_trampa_maximo_local.png');
print(figura_caso_3, ruta_imagen_salida, '-dpng', '-r150');
printf('\nGrafica guardada en: %s\n', ruta_imagen_salida);
close(figura_caso_3);
