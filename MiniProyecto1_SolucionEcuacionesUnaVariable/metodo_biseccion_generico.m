function [raiz_aproximada, historial_iteraciones, estado_convergencia] = metodo_biseccion_generico( ...
        funcion_objetivo, extremo_inferior_intervalo_a, extremo_superior_intervalo_b, ...
        tolerancia_error_absoluto, maximo_numero_iteraciones)
% =========================================================================
% METODO_BISECCION_GENERICO
% -------------------------------------------------------------------------
% Implementacion didactica del metodo de Biseccion para resolver f(x) = 0
% en un intervalo [a, b] que satisface el Teorema de Bolzano:
%
%       f(a) * f(b) < 0   =>   existe al menos una raiz real en (a, b).
%
% El criterio de paro empleado es el ancho del intervalo dividido entre 2,
% que coincide con la cota maxima del error absoluto sobre la raiz:
%
%       error_k = (b_k - a_k) / 2  <=  tolerancia
%
% A diferencia de una version minima, esta funcion devuelve toda la
% trayectoria (a_k, b_k, c_k, f(c_k), error_k) para que el archivo
% invocador pueda graficar la convergencia y analizar las raices que
% PUDIERA OMITIR (caso de raices multiples / pares de raices cercanas
% sin cambio de signo entre ellas).
%
% PARAMETROS DE ENTRADA
%   funcion_objetivo                 : handle de funcion f(x).
%   extremo_inferior_intervalo_a     : extremo izquierdo a del intervalo.
%   extremo_superior_intervalo_b     : extremo derecho b del intervalo.
%   tolerancia_error_absoluto        : criterio de paro sobre (b-a)/2.
%   maximo_numero_iteraciones        : tope de iteraciones.
%
% PARAMETROS DE SALIDA
%   raiz_aproximada                  : ultimo punto medio c calculado.
%   historial_iteraciones            : matriz [k, a_k, b_k, c_k, f(a_k),
%                                      f(b_k), f(c_k), error_k].
%   estado_convergencia              : cadena con el diagnostico final.
% =========================================================================

    valor_funcion_en_a = funcion_objetivo(extremo_inferior_intervalo_a);
    valor_funcion_en_b = funcion_objetivo(extremo_superior_intervalo_b);

    % --- Verificacion del cambio de signo (condicion de Bolzano) --------
    % Si no se cumple, la biseccion CLASICA no puede ni siquiera arrancar.
    if valor_funcion_en_a * valor_funcion_en_b > 0
        raiz_aproximada       = NaN;
        historial_iteraciones = [];
        estado_convergencia   = 'FALLA_SIN_CAMBIO_DE_SIGNO_EN_INTERVALO';
        printf(['ADVERTENCIA: f(a)=%.6f y f(b)=%.6f tienen el mismo ', ...
                'signo. Biseccion no puede aplicarse.\n'], ...
               valor_funcion_en_a, valor_funcion_en_b);
        return;
    end

    indice_iteracion           = 0;
    a_k                        = extremo_inferior_intervalo_a;
    b_k                        = extremo_superior_intervalo_b;
    error_absoluto_iteracion   = (b_k - a_k) / 2;
    historial_iteraciones      = [];
    estado_convergencia        = 'NO_INICIADO';
    punto_medio_c_k            = (a_k + b_k) / 2;

    printf('\n');
    printf('%-4s | %-14s | %-14s | %-14s | %-14s | %-14s | %-14s | %-14s\n', ...
           'k', 'a_k', 'b_k', 'c_k', 'f(a_k)', 'f(b_k)', 'f(c_k)', 'error_k');
    printf('%s\n', repmat('-', 1, 130));

    while (error_absoluto_iteracion > tolerancia_error_absoluto) && ...
          (indice_iteracion < maximo_numero_iteraciones)

        punto_medio_c_k        = (a_k + b_k) / 2;
        valor_funcion_en_c     = funcion_objetivo(punto_medio_c_k);
        valor_funcion_en_a     = funcion_objetivo(a_k);
        valor_funcion_en_b     = funcion_objetivo(b_k);

        historial_iteraciones = [historial_iteraciones; ...
            indice_iteracion, a_k, b_k, punto_medio_c_k, ...
            valor_funcion_en_a, valor_funcion_en_b, ...
            valor_funcion_en_c, error_absoluto_iteracion];

        printf('%-4d | %-14.8f | %-14.8f | %-14.8f | %-14.8f | %-14.8f | %-14.8f | %-14.8f\n', ...
               indice_iteracion, a_k, b_k, punto_medio_c_k, ...
               valor_funcion_en_a, valor_funcion_en_b, ...
               valor_funcion_en_c, error_absoluto_iteracion);

        if valor_funcion_en_c == 0
            estado_convergencia = 'CONVERGENCIA_EXACTA_EN_PUNTO_MEDIO';
            raiz_aproximada     = punto_medio_c_k;
            return;
        elseif valor_funcion_en_a * valor_funcion_en_c < 0
            b_k = punto_medio_c_k;
        else
            a_k = punto_medio_c_k;
        end

        indice_iteracion          = indice_iteracion + 1;
        error_absoluto_iteracion  = (b_k - a_k) / 2;
    end

    raiz_aproximada = (a_k + b_k) / 2;

    if error_absoluto_iteracion <= tolerancia_error_absoluto
        estado_convergencia = 'CONVERGENCIA_EXITOSA';
    else
        estado_convergencia = ...
            'FALLA_NO_CONVERGENCIA_EN_MAXIMO_ITERACIONES';
    end
end
