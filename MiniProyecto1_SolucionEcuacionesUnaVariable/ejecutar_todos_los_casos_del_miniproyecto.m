% =========================================================================
% EJECUTAR_TODOS_LOS_CASOS_DEL_MINIPROYECTO
% -------------------------------------------------------------------------
% Script orquestador que dispara secuencialmente los cuatro experimentos
% del Mini-Proyecto # 1: "Solucion de ecuaciones de una variable".
%
% Cada caso se ejecuta de manera AISLADA (limpieza previa de variables y
% figuras) y deja en la carpeta una imagen PNG con sus resultados graficos
% y todo su detalle iteracion por iteracion en la consola.
%
% Uso:
%   >> cd MiniProyecto1_SolucionEcuacionesUnaVariable
%   >> ejecutar_todos_los_casos_del_miniproyecto
% =========================================================================

ruta_carpeta_actual = fileparts(mfilename('fullpath'));
addpath(ruta_carpeta_actual);

archivos_a_ejecutar_en_orden = { ...
    'caso1_NewtonRaphson_CicloLimite_FuncionCubicaModificada.m', ...
    'caso2_NewtonRaphson_RaizOscilante_FuncionRaizCubica.m', ...
    'caso3_NewtonRaphson_TrampaMaximoLocal_FuncionSenoMasCuadratica.m', ...
    'caso4_Biseccion_TrampaRaizOmitida_PolinomioPerturbado.m' ...
};

for indice_caso = 1:length(archivos_a_ejecutar_en_orden)
    nombre_archivo_caso = archivos_a_ejecutar_en_orden{indice_caso};
    printf('\n\n#########################################################\n');
    printf('## EJECUTANDO ARCHIVO: %s\n', nombre_archivo_caso);
    printf('#########################################################\n');
    run(fullfile(ruta_carpeta_actual, nombre_archivo_caso));
end

printf('\nTodos los casos del Mini-Proyecto #1 finalizaron.\n');
printf('Revise los archivos PNG generados en la carpeta:\n  %s\n', ...
       ruta_carpeta_actual);
