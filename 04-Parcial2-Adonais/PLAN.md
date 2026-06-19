# Plan de implementación — Parcial 2 (Adonais)

Objetivo: un script **Octave** por tema, lo más **interactivo** posible, que imprima
**todos los pasos intermedios** (no solo el resultado final). Cada archivo:

- Se ejecuta solo (`octave nombre.m`) con un caso de ejemplo cargado.
- Imprime con cabeceras de caja (estilo del repo) cada paso del algoritmo.
- Implementa el método **a mano** (bucles / álgebra) Y muestra la **verificación**
  con el comando nativo de Octave de la tabla guía.
- Genera una **gráfica** cuando aplica (puntos, polinomio, área, campo de pendientes).
- Termina con una **tabla resumen** y observaciones.

## Convenciones comunes

- Cabeceras con `fprintf` y caracteres de caja (`╔ ═ ╗ ║ ╚ ╝ ├ ┼ ┤`), igual que
  `Parcial1/ejemplo_paso_a_paso_babilonia.m`.
- Vectorización con operadores punto (`.^`, `.*`, `./`).
- Sistemas lineales resueltos con backslash: `x = A \ b`.
- Polinomios en formato Octave: `p = [a_n, ..., a_1, a_0]` (mayor a menor grado).
- Cada script define los datos al inicio en un bloque `% --- DATOS ---`
  fácil de cambiar para el examen.

## Archivos a crear

| # | Archivo | Tema | Implementa a mano | Verificación nativa | Gráfica |
|---|---------|------|-------------------|---------------------|---------|
| 1 | `t1_interpolacion_newton.m`   | Interpolación de Newton (diferencias divididas) | Tabla de diferencias divididas + construcción de `P_n(x)` | `polyfit` / `interp1` | Puntos + polinomio |
| 2 | `t1_interpolacion_lagrange.m` | Interpolación de Lagrange | Bases `L_i(x)` término a término | `interp1(...,'linear'/'spline')` | Puntos + polinomio + bases |
| 3 | `t2_spline_cubico.m`          | Trazador cúbico | Sistema de continuidad de `S'`, `S''` (matriz tridiagonal) | `spline(x,y,xi)` | Puntos + tramos del spline |
| 4 | `t3_minimos_cuadrados.m`      | Ajuste por mínimos cuadrados | Ecuaciones normales `Z'Z A = Z'Y` paso a paso | `polyfit` + `polyval` | Puntos + curva de ajuste |
| 5 | `t4_diferenciacion.m`         | Diferenciación numérica | Adelante, atrás, centrada (f' y f''), con error | `diff(y)./diff(x)`, `gradient` | f y su derivada |
| 6 | `t5_trapecio.m`               | Trapecio compuesta | Suma `h/2[f0+fn+2Σf_i]` término a término | `trapz(x,y)` | Área bajo trapecios |
| 7 | `t5_simpson13.m`              | Simpson 1/3 compuesta | Suma con pesos 1,4,2,...,4,1 | `quad` | Área (parábolas) |
| 8 | `t5_simpson38.m`              | Simpson 3/8 | Suma con pesos 1,3,3,2,... | `quad` | Área |
| 9 | `t6_euler.m`                  | EDO — Euler | `y_{i+1}=y_i+h f(t_i,y_i)` tabla iteración a iteración | `lsode` | Solución numérica vs exacta |
| 10| `t6_euler_mejorado_rk4.m`     | EDO — Heun (Euler mejorado) y RK4 | Predictor-corrector y 4 pendientes `k1..k4` | `lsode` | Comparación de las 3 |
| 11| `run_todos.m`                 | Menú interactivo | Llama a cada tema con `menu()` / selección | — | — |

## Estructura interna estándar de cada script

```
% --- DATOS ---            (editable para el examen)
% --- PASO 1 ... PASO N -- (fprintf de cada cálculo intermedio)
% --- VERIFICACIÓN ---     (comando nativo Octave)
% --- TABLA RESUMEN ---    (formato tabla con cajas)
% --- GRÁFICA ---          (figure + plot, guardar PNG opcional)
% --- OBSERVACIONES ---    (notas de convergencia/error)
```

## Orden de ejecución sugerido

1. Temas 1–3 (interpolación + spline + ajuste) comparten datos `(x,y)` y son base.
2. Temas 4–5 (diferenciación e integración) sobre una `f(x)` conocida (para comparar error).
3. Tema 6 (EDO) con PVI que tenga solución exacta conocida.

## Interactividad — DECIDIDO: "corrido con flag"

- Cada script corre de **corrido** (imprime todos los pasos sin detenerse).
- Al inicio de cada archivo: `PASO_A_PASO = false;`
  - Si se pone en `true`, se activan pausas `input('Enter para continuar...')`
    entre pasos, vía una función auxiliar `pausa(PASO_A_PASO)`.
- `run_todos.m` usa `menu("Elige tema", ...)` para lanzar cada script.
- Los datos editables (`x`, `y`, `h`, límites, `x` a evaluar) van en el bloque
  `% --- DATOS ---` al inicio, claramente marcados para cambiarlos en el examen.
