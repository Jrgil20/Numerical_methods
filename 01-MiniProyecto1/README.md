# Mini-Proyecto 1 — Análisis de Newton y Bisección

Estudio comparativo profundo de dos métodos de búsqueda de raíces: **Newton-Raphson** y **Bisección**.

## 📁 Estructura

```
01-MiniProyecto1/
├── algoritmos/        Implementación de métodos (genéricos)
├── casos/             Casos de prueba (fallos, convergencia)
├── docs/              Documentación (análisis de fallos)
└── salidas/           Resultados y gráficas
```

## 🎯 Objetivo

Analizar **casos de fallo**:
1. **Ciclo límite** — Newton oscila alrededor de la raíz
2. **Raíz oscilante** — Convergencia lenta y oscilante
3. **Máximo local** — Newton queda atrapado en un máximo
4. **Raíz omitida** — Bisección salta una raíz

## 📋 Scripts principales

| Carpeta | Archivo | Descripción |
|---------|---------|-----------|
| `algoritmos/` | `metodo_newton_raphson_generico.m` | Newton genérico |
| `algoritmos/` | `metodo_biseccion_generico.m` | Bisección genérica |
| `algoritmos/` | `dibujar_panel_iteracion_newton_con_maximo_local.m` | Visualización de fallo |
| `casos/` | `caso1_*.m` | Ciclo límite |
| `casos/` | `caso2_*.m` | Raíz oscilante |
| `casos/` | `caso3_*.m` | Máximo local |
| `casos/` | `caso4_*.m` | Raíz omitida |
| `casos/` | `ejecutar_todos_los_casos_del_miniproyecto.m` | **Ejecutar todos** |

## 🚀 Inicio rápido

```octave
% Ejecutar todos los casos (recomendado)
cd casos
octave ejecutar_todos_los_casos_del_miniproyecto.m

% O un caso individual
octave caso1_NewtonRaphson_CicloLimite_FuncionCubicaModificada.m
octave caso2_NewtonRaphson_RaizOscilante_FuncionRaizCubica.m
octave caso3_NewtonRaphson_TrampaMaximoLocal_FuncionSenoMasCuadratica.m
octave caso4_Biseccion_TrampaRaizOmitida_PolinomioPerturbado.m
```

## 📚 Documentación

Ver `docs/` para análisis detallado de cada caso.

## 💡 Aprendizajes clave

1. **Newton** converge cuadráticamente (muy rápido) pero puede fallar
2. **Bisección** es lenta pero siempre converge si hay cambio de signo
3. Conocer los límites de cada método es crítico
4. Visualización ayuda a entender el comportamiento

---

**Relación con otros temas:**
- Métodos básicos: [00-Fundamentos/02-Ecuaciones-NoLineales/](../00-Fundamentos/02-Ecuaciones-NoLineales/)
- Parcial 1: [02-Parcial1/](../02-Parcial1/)
