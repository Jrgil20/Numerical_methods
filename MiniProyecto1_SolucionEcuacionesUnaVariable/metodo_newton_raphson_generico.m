function [raiz_aproximada, historial_iteraciones, estado_convergencia] = metodo_newton_raphson_generico( ...
        funcion_objetivo, derivada_funcion_objetivo, valor_inicial_x0, ...
        tolerancia_error_absoluto, maximo_numero_iteraciones, ...
        umbral_minimo_derivada, umbral_maximo_magnitud_iterado)
% =========================================================================
% METODO_NEWTON_RAPHSON_GENERICO
% -------------------------------------------------------------------------
% Implementacion didactica del metodo de Newton-Raphson para la solucion
% de ecuaciones no lineales de una variable f(x) = 0.
%
% La formula iterativa empleada es la clasica:
%
%       x_{k+1} = x_k - f(x_k) / f'(x_k)
%
% A diferencia de un Newton-Raphson "minimo", esta version registra TODA
% la trayectoria de iterados, los valores de la funcion y de su derivada,
% y los errores absolutos sucesivos, de modo que el archivo invocador
% pueda graficar y analizar las situaciones de FALLA del metodo.
%
% PARAMETROS DE ENTRADA
%   funcion_objetivo                : handle de funcion f(x) (anonimo).
%   derivada_funcion_objetivo       : handle de funcion f'(x) (anonimo).
%   valor_inicial_x0                : iterado inicial x_0.
%   tolerancia_error_absoluto       : criterio de paro |x_{k+1} - x_k|.
%   maximo_numero_iteraciones       : tope superior de iteraciones.
%   umbral_minimo_derivada          : si |f'(x_k)| cae por debajo de este
%                                     valor, el metodo se considera
%                                     "colapsado por derivada nula".
%   umbral_maximo_magnitud_iterado  : si |x_k| supera este umbral, el
%                                     metodo se declara divergente.
%
% PARAMETROS DE SALIDA
%   raiz_aproximada                 : ultima aproximacion calculada.
%   historial_iteraciones           : matriz [k, x_k, f(x_k), f'(x_k),
%                                     x_{k+1}, error_k] con TODA la
%                                     trayectoria; util para graficar.
%   estado_convergencia             : cadena explicativa que indica si
%                                     hubo convergencia, ciclo limite,
%                                     divergencia, derivada nula, etc.
% =========================================================================

    % --- Asignacion de valores por defecto si no se pasan ---------------
    if nargin < 6 || isempty(umbral_minimo_derivada)
        umbral_minimo_derivada = 1e-12;
    end
    if nargin < 7 || isempty(umbral_maximo_magnitud_iterado)
        umbral_maximo_magnitud_iterado = 1e12;
    end

    iterado_actual               = valor_inicial_x0;
    error_absoluto_iteracion     = Inf;
    indice_iteracion             = 0;
    historial_iteraciones        = [];   % Se ira concatenando fila a fila.
    estado_convergencia          = 'NO_INICIADO';

    % Encabezado de la tabla de seguimiento por consola.
    printf('\n');
    printf('%-4s | %-18s | %-18s | %-18s | %-18s | %-18s\n', ...
           'k', 'x_k', 'f(x_k)', "f'(x_k)", 'x_{k+1}', '|x_{k+1}-x_k|');
    printf('%s\n', repmat('-', 1, 110));

    while (error_absoluto_iteracion > tolerancia_error_absoluto) && ...
          (indice_iteracion < maximo_numero_iteraciones)

        valor_funcion_en_iterado   = funcion_objetivo(iterado_actual);
        valor_derivada_en_iterado  = derivada_funcion_objetivo(iterado_actual);

        % --- Deteccion de FALLA por derivada (cuasi) nula ----------------
        % Esta es la falla clasica del maximo/minimo local: si f'(x_k)
        % se acerca a cero, la correccion -f(x_k)/f'(x_k) explota y el
        % metodo lanza al iterado al "infinito numerico".
        if abs(valor_derivada_en_iterado) < umbral_minimo_derivada
            historial_iteraciones = [historial_iteraciones; ...
                indice_iteracion, iterado_actual, ...
                valor_funcion_en_iterado, valor_derivada_en_iterado, ...
                NaN, NaN];
            printf('%-4d | %-18.10f | %-18.10f | %-18.3e | %-18s | %-18s\n', ...
                   indice_iteracion, iterado_actual, ...
                   valor_funcion_en_iterado, valor_derivada_en_iterado, ...
                   'NaN (f''~0)', 'NaN');
            estado_convergencia = 'FALLA_DERIVADA_CUASI_NULA';
            raiz_aproximada     = iterado_actual;
            return;
        end

        iterado_siguiente        = iterado_actual ...
                                 - valor_funcion_en_iterado ...
                                 / valor_derivada_en_iterado;
        error_absoluto_iteracion = abs(iterado_siguiente - iterado_actual);

        historial_iteraciones = [historial_iteraciones; ...
            indice_iteracion, iterado_actual, ...
            valor_funcion_en_iterado, valor_derivada_en_iterado, ...
            iterado_siguiente, error_absoluto_iteracion];

        printf('%-4d | %-18.10f | %-18.10f | %-18.10f | %-18.10f | %-18.10f\n', ...
               indice_iteracion, iterado_actual, ...
               valor_funcion_en_iterado, valor_derivada_en_iterado, ...
               iterado_siguiente, error_absoluto_iteracion);

        % --- Deteccion de divergencia explosiva --------------------------
        if abs(iterado_siguiente) > umbral_maximo_magnitud_iterado || ...
           ~isfinite(iterado_siguiente)
            estado_convergencia = 'FALLA_DIVERGENCIA_EXPLOSIVA';
            raiz_aproximada     = iterado_siguiente;
            return;
        end

        iterado_actual   = iterado_siguiente;
        indice_iteracion = indice_iteracion + 1;
    end

    raiz_aproximada = iterado_actual;

    % --- Diagnostico final del estado del metodo ------------------------
    if error_absoluto_iteracion <= tolerancia_error_absoluto
        estado_convergencia = 'CONVERGENCIA_EXITOSA';
    elseif indice_iteracion >= maximo_numero_iteraciones
        % Aqui distinguimos un posible CICLO LIMITE (la trayectoria
        % oscila entre dos o mas valores sin contraerse). Para un ciclo
        % de periodo 2 se cumple x_{N+1} ~ x_{N-1}, es decir: el valor
        % actual (siguiente iterado tras el ultimo registro) coincide
        % con el guardado en la fila anterior (k-1 respecto al final).
        if size(historial_iteraciones, 1) >= 4
            x_anterior_uno  = historial_iteraciones(end-1, 2);
            x_anterior_dos  = historial_iteraciones(end-2, 2);
            if abs(iterado_actual - x_anterior_uno) < 1e-8 && ...
               abs(iterado_actual - x_anterior_dos) > 1e-8
                estado_convergencia = ...
                    'FALLA_CICLO_LIMITE_PERIODO_2';
            else
                estado_convergencia = ...
                    'FALLA_NO_CONVERGENCIA_EN_MAXIMO_ITERACIONES';
            end
        else
            estado_convergencia = ...
                'FALLA_NO_CONVERGENCIA_EN_MAXIMO_ITERACIONES';
        end
    end
end
