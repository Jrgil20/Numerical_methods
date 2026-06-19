function pausa(activo)
    % PAUSA  Detiene la ejecución hasta pulsar Enter si 'activo' es true.
    %   Se usa para el modo PASO_A_PASO de los scripts del Parcial 2.
    %   Uso:  pausa(PASO_A_PASO)
    if nargin >= 1 && activo
        input('   ... [Enter para continuar] ', 's');
    end
end
