# Parcial 2 — Adonais (Octave)

Scripts interactivos, uno por tema, que muestran **todos los pasos intermedios**
de cada método numérico, lo verifican con el comando nativo de Octave y generan
una gráfica.

## Cómo usar

Desde Octave, situado en esta carpeta:

```octave
run_todos          % menú interactivo para elegir cualquier tema
```

O ejecuta un tema directamente:

```octave
t1_interpolacion_newton
t5_simpson13
t6_euler_mejorado_rk4
```

## Modo paso a paso

Cada script tiene al inicio:

```octave
PASO_A_PASO = false;   % ponlo en true para pausar entre pasos (Enter)
```

Con `true`, la ejecución se detiene en cada paso hasta que pulses **Enter**
(útil para estudiar o presentar). La pausa la maneja el helper `pausa.m`.

## Datos editables

Cada script tiene un bloque `% --- DATOS ---` al inicio con los valores del
problema (nodos, `h`, límites, punto a evaluar...). Cámbialos ahí para
resolver el problema concreto del examen.

## Archivos

| Archivo | Tema | Verificación nativa |
|---------|------|---------------------|
| `t1_interpolacion_newton.m`   | Interpolación de Newton (dif. divididas) | `polyfit` / `interp1` |
| `t1_interpolacion_lagrange.m` | Interpolación de Lagrange (bases `L_i`)  | `polyfit` |
| `t2_spline_cubico.m`          | Trazador cúbico natural (sist. tridiagonal) | `spline` |
| `t3_minimos_cuadrados.m`      | Mínimos cuadrados (ecuaciones normales)  | `polyfit` / `polyval` |
| `t4_diferenciacion.m`         | Diferenciación numérica (adelante/atrás/centrada) | `diff`, `gradient` |
| `t5_trapecio.m`               | Trapecio compuesta | `trapz` |
| `t5_simpson13.m`              | Simpson 1/3 compuesta (n par) | `quad` |
| `t5_simpson38.m`              | Simpson 3/8 (n múltiplo de 3) | `quad` |
| `t6_euler.m`                  | EDO — Euler | `lsode` |
| `t6_euler_mejorado_rk4.m`     | EDO — Heun y Runge-Kutta 4 | `lsode` |
| `run_todos.m`                 | Menú interactivo | — |
| `pausa.m`                     | Helper de pausa para el modo paso a paso | — |

Plan detallado en [PLAN.md](PLAN.md).

> Nota: estos scripts no se ejecutaron localmente porque la máquina de
> desarrollo no tenía Octave instalado. Revisa la primera ejecución por si
> algún dato de ejemplo necesita ajuste.
