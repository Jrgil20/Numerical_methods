# Mini-Proyecto # 1 — Solución de ecuaciones de una variable

Análisis experimental y analítico de las **fallas de los métodos de Newton-Raphson y Bisección** sobre cuatro funciones particularmente difíciles. Implementado en **GNU Octave / Matlab**.

> Toda la implementación es estilo *script* + *funciones genéricas reutilizables*, con nombres de variables y archivos largos pero auto-descriptivos para que el código se lea casi como un texto.

---

## 1. ¿Cómo se usa?

### Requisitos

- GNU Octave **8.x** o superior (también funciona en Matlab R2018b+).
- En Linux (Ubuntu/Debian) se instala con: `sudo apt-get install -y octave`.

### Ejecución de los cuatro casos en una sola corrida

```bash
cd MiniProyecto1_SolucionEcuacionesUnaVariable
octave --no-gui --quiet --eval "ejecutar_todos_los_casos_del_miniproyecto"
```

Esto:

1. Imprime en consola la **tabla iteración por iteración** de cada caso.
2. Imprime el **estado final** (convergencia, ciclo, divergencia, etc.).
3. Genera cuatro imágenes PNG con las **gráficas** de cada caso en la misma carpeta.

### Ejecución de un único caso

```bash
octave --no-gui --quiet --eval "caso1_NewtonRaphson_CicloLimite_FuncionCubicaModificada"
```

(análogamente para `caso2_…`, `caso3_…`, `caso4_…`).

### Desde la GUI de Octave o Matlab

```matlab
>> cd MiniProyecto1_SolucionEcuacionesUnaVariable
>> ejecutar_todos_los_casos_del_miniproyecto
```

---

## 2. Archivos del proyecto

| Archivo | Descripción |
|---|---|
| `metodo_newton_raphson_generico.m` | Motor genérico del método de Newton-Raphson. Acepta `f`, `f'`, `x_0`, tolerancia, máximo de iteraciones y umbrales para detectar **derivada casi nula** y **divergencia explosiva**. Devuelve la trayectoria completa y un **estado final** (convergencia, ciclo límite, divergencia, etc.). |
| `metodo_biseccion_generico.m` | Motor genérico del método de Bisección. Verifica la condición de Bolzano `f(a)·f(b) < 0`, registra la trayectoria `(a_k, b_k, c_k, f(c_k), error_k)` y devuelve un estado final. |
| `caso1_NewtonRaphson_CicloLimite_FuncionCubicaModificada.m` | Caso 1: ciclo límite de período 2 sobre `f(x) = x³ − 5x` con `x₀ = 1`. |
| `caso2_NewtonRaphson_RaizOscilante_FuncionRaizCubica.m` | Caso 2: divergencia geométrica `|x_{k+1}| = 2·|x_k|` sobre `f(x) = ∛x`. |
| `caso3_NewtonRaphson_TrampaMaximoLocal_FuncionSenoMasCuadratica.m` | Caso 3: trampa del máximo local sobre `f(x) = sin(x) + x²/20`. |
| `caso4_Biseccion_TrampaRaizOmitida_PolinomioPerturbado.m` | Caso 4: bisección sobre `f(x) = (x − 1.1)²·(x − 2) − 0.01`. |
| `dibujar_panel_iteracion_newton_con_maximo_local.m` | Función auxiliar de graficación reutilizada por el Caso 3. |
| `ejecutar_todos_los_casos_del_miniproyecto.m` | Script orquestador que dispara los cuatro casos en orden. |
| `salida_grafica_caso<N>_*.png` | Gráficas generadas automáticamente por cada caso. |

---

## 3. Caso 1 — Bucle infinito de la función cúbica modificada

### Función y planteamiento

`f(x) = x³ − 5x`, `f'(x) = 3x² − 5`.
Raíces reales: `x = −√5`, `x = 0`, `x = √5`.
Iterado inicial: `x₀ = 1`.

### Demostración analítica del ciclo límite

| iteración | `x_k` | `f(x_k)` | `f'(x_k)` | `x_{k+1} = x_k − f/f'` |
|---|---|---|---|---|
| 0 | 1 | −4 | −2 | 1 − (−4)/(−2) = **−1** |
| 1 | −1 | 4 | −2 | −1 − 4/(−2) = **1** |
| 2 | 1 | −4 | −2 | **−1** |
| … | … | … | … | … |

El iterado regresa exactamente a `x₀`. La sucesión genera el **ciclo límite de período 2**:
`1 → −1 → 1 → −1 → …` y **nunca** converge a ninguna de las tres raíces reales.

### Resultado experimental (script)

```
Estado final: FALLA_CICLO_LIMITE_PERIODO_2
Última aproximación: 1.0000000000
```

La tabla generada por el script muestra que las 20 primeras iteraciones cumplen exactamente con la predicción analítica.

### Gráfica

`salida_grafica_caso1_ciclo_limite_funcion_cubica.png`: muestra `f(x)`, las tres raíces reales (verde), los iterados `x₀, x₁, …` (rojo) y las rectas tangentes (rojo punteado) que cruzan el eje X alternando entre `+1` y `−1`.

---

## 4. Caso 2 — Problema de la raíz oscilante (raíz cúbica)

### Función y planteamiento

`f(x) = ∛x`, `f'(x) = (1/3)·x^(−2/3)`. Única raíz real: `x = 0`.
En el script se implementa como `sign(x).*abs(x).^(1/3)` para que esté bien definida y sea real para `x < 0` (de lo contrario `x.^(1/3)` devolvería un complejo).

### Demostración analítica

Aplicando Newton-Raphson:

```
x_{k+1} = x_k − f(x_k)/f'(x_k)
        = x_k − x_k^(1/3) / [(1/3)·x_k^(−2/3)]
        = x_k − 3·x_k^(1/3)·x_k^(2/3)
        = x_k − 3·x_k
        = −2·x_k
```

Por lo tanto `|x_{k+1}| = 2·|x_k|`: la magnitud crece **geométricamente** con razón 2 y el signo se alterna en cada paso. El método **nunca** puede converger a `x = 0` partiendo de `x₀ ≠ 0`.

### Resultado experimental (script con `x₀ = 0.5`)

```
0   |  0.5         → −1
1   | −1           →  2
2   |  2           → −4
3   | −4           →  8
…
11  | −1024        →  2048
Estado final: FALLA_NO_CONVERGENCIA_EN_MAXIMO_ITERACIONES
```

Cada iterado duplica la magnitud y cambia de signo, exactamente como predice la fórmula `x_{k+1} = −2·x_k`.

### Gráfica

`salida_grafica_caso2_raiz_oscilante_cubica.png` (dos paneles):

- **Panel A**: `f(x) = ∛x` con los iterados rojos y las tangentes rojas punteadas — se ve cómo cada tangente cruza el eje X en el punto `−2·x_k`.
- **Panel B**: `|x_k|` en escala **logarítmica**, comparando los datos experimentales con la curva teórica `|x₀|·2^k`. Las dos rectas se solapan, validando la demostración analítica.

---

## 5. Caso 3 — Trampa del máximo local

### Función y planteamiento

`f(x) = sin(x) + x²/20`, `f'(x) = cos(x) + x/10`.

La derivada se anula en un **máximo local** cuya abscisa `x*` cumple `cos(x*) = −x*/10`. Numéricamente, el script localiza:

```
x*_max_local ≈ 1.74633     (con f(x*) ≈ 1.137)
```

Cerca de `x*`, la corrección de Newton

```
Δ_k = − f(x_k) / f'(x_k)
```

se vuelve **arbitrariamente grande** porque `f'(x_k) → 0` mientras `f(x*) ≠ 0`. Es la "trampa del máximo local": Newton lanza al iterado a un punto extremadamente lejano de cualquier raíz real.

### Dos sub-experimentos

> **Aviso académico.** El enunciado pide partir de `x₀ = 1.08216` y afirma que el método "colapsa en la segunda iteración". Al ejecutar literalmente ese caso, **el método NO se queda atrapado**: la primera iteración produce un salto enorme (`x₀ = 1.08216 → x₁ ≈ −0.55`), pero la dinámica posterior, por casualidad, **converge a `x = 0`** en cinco pasos. Para mostrar simultáneamente lo pedido y la verdadera mecánica del colapso por máximo local, el script ejecuta **dos sub-experimentos**:

#### Sub-experimento 3A — `x₀ = 1.08216` (literal del enunciado)

```
k | x_k          | f(x_k)       | f'(x_k)      | x_{k+1}
--+--------------+--------------+--------------+-----------
0 |  1.08216     |  0.94153     |  0.57764     | -0.54780
1 | -0.54780     | -0.50581     |  0.79889     |  0.08533
2 |  0.08533     |  0.08559     |  1.00489     |  0.00016
3 |  0.00016     |  0.00016     |  1.00002     |  ~0
4 |  ~0          |  ~0          |  1.00000     |  ~0
Estado final: CONVERGENCIA_EXITOSA  (en x ≈ 7.5e−20)
```

**Observación**: el primer paso lanza el iterado de `1.08` a `−0.55` (salto de magnitud 1.63), un comportamiento **extremadamente inestable** causado precisamente por la cercanía con `x*_max_local`. Que el método converja después es una **coincidencia favorable** del paisaje de la función, **no** una virtud de Newton-Raphson en este punto. Geométricamente, la pendiente `f'(1.08) ≈ 0.58` ya es lo bastante pequeña frente a `f(1.08) ≈ 0.94` para producir un *overshoot* que en la práctica un ingeniero consideraría una falla, aunque al final el algoritmo se recupere.

#### Sub-experimento 3B — `x₀ = 1.7` (cerca de `x*_max_local`)

```
k | x_k       | f'(x_k)   | x_{k+1}
--+-----------+-----------+-----------
0 |  1.7      |  0.0412   | −25.91
1 | −25.91    | −1.875    |  −8.39
2 |  −8.39    | −1.346    |  −6.41
3 |  −6.41    |  0.350    | −11.92
…   (oscilación caótica)
Estado final: FALLA_NO_CONVERGENCIA_EN_MAXIMO_ITERACIONES
```

Aquí, con `f'(1.7) ≈ 0.041`, la primera iteración lanza al iterado a `x₁ ≈ −26`. La trayectoria se vuelve **caótica**, alterna signos y nunca encuentra ninguna raíz. Esta es la **falla "de libro de texto" del máximo local**.

### Gráfica

`salida_grafica_caso3_trampa_maximo_local.png`: dos paneles uno por sub-experimento, con `f(x)` (azul), `f'(x)` (magenta punteada), el máximo local resaltado con un triángulo amarillo, y las tangentes que conectan iterados sucesivos.

---

## 6. Caso 4 — Trampa de la raíz omitida (Bisección sobre polinomio perturbado)

### Función y planteamiento

`f(x) = (x − 1.1)²·(x − 2) − 0.01` en el intervalo `[1, 3]`.

La función sin perturbar `g(x) = (x − 1.1)²·(x − 2)` posee:

- una **raíz doble** en `x = 1.1` (la curva toca el eje pero no lo cruza),
- una **raíz simple** en `x = 2`.

Al introducir el término `−0.01` la función se desplaza hacia abajo: la tangencia en `x = 1.1` desaparece y, para esta perturbación, se obtiene **una sola raíz real** en `[1, 3]`, cerca de `x ≈ 2.0083`.

### Verificación de la condición de cambio de signo (Bolzano)

```
f(1) = (1 − 1.1)²·(1 − 2) − 0.01 = 0.01·(−1) − 0.01 = −0.02
f(3) = (3 − 1.1)²·(3 − 2) − 0.01 = 3.61          − 0.01 =  3.60
f(1)·f(3) = −0.072 < 0    →    se cumple cambio de signo ✓
```

Por lo tanto la bisección puede aplicarse y, según Bolzano, existe al menos **una** raíz en `(1, 3)`.

### Resultado experimental (script)

```
Iteraciones: 20
Estado final: CONVERGENCIA_EXITOSA
Raíz aproximada: x ≈ 2.01202297    (error ≤ 1e−6)
```

### ¿Por qué se considera un fallo desde el punto de vista del diseño?

1. **El sistema físico tiene una "casi-raíz" cerca de `x = 1.1`** (donde la función original `g(x)` tenía una raíz doble). En esa zona, `f(x) ≈ −0.01`: la función *casi* toca el eje X pero no lo cruza. Es una zona de **alta sensibilidad** del modelo (basta una perturbación pequeña en sentido contrario, `+0.01`, para que aparezcan dos raíces reales adicionales en torno a `x = 1.1`).
2. **Bisección sólo reacciona a cambios de signo**: como en `[1, ~2.0083]` la función es estrictamente negativa (con un mínimo en `x ≈ 1.7` de valor ≈ `−0.118`), el método **no puede detectar** la región casi-cero. El intervalo se contrae sin reportar nada que ocurra cerca de `x = 1.1`.
3. Para un ingeniero/diseñador esto es un **fallo de información**: el solver entrega "una raíz en ≈ 2.012" como si el problema fuera trivial, y oculta por completo el comportamiento físico-matemático **mucho más interesante** que tiene la función en otra parte del intervalo (cuasi-resonancia, multiplicidad escondida, alta sensibilidad a perturbaciones del parámetro).

En resumen: la bisección convergió "exitosamente" desde el punto de vista numérico, pero **falló en describir el sistema** desde el punto de vista del diseño. Este caso ilustra por qué la bisección, aunque "lenta pero segura", **no es suficiente** cuando se requiere localizar todas las raíces relevantes (ni siquiera para detectar raíces de multiplicidad par).

### Gráfica

`salida_grafica_caso4_biseccion_raiz_omitida.png` (dos paneles):

- **Panel A**: `f(x)` en `[0.5, 3.2]`, con la zona casi-cero alrededor de `x = 1.1` resaltada en rosa, las dos "casi-raíces" marcadas con asterisco negro (`x = 1.1` y `x = 2.0`), la raíz hallada por bisección (verde) y los puntos medios sucesivos `c_k` (rojo).
- **Panel B**: `(b_k − a_k)/2` frente a `k` en escala logarítmica — la bisección reduce su error por un factor de 2 en cada iteración, comportamiento que se traduce en una recta descendente.

---

## 7. Resumen comparativo

| Caso | Método | Función | Punto / intervalo | Estado final | Lección |
|---|---|---|---|---|---|
| 1 | Newton-Raphson | `x³ − 5x` | `x₀ = 1` | `FALLA_CICLO_LIMITE_PERIODO_2` | El iterado puede atraparse en una órbita periódica que nunca converge. |
| 2 | Newton-Raphson | `∛x` | `x₀ = 0.5` | `FALLA_NO_CONVERGENCIA_EN_MAXIMO_ITERACIONES` | Con derivadas no acotadas en la raíz, Newton puede divergir geométricamente. |
| 3A | Newton-Raphson | `sin x + x²/20` | `x₀ = 1.08216` | `CONVERGENCIA_EXITOSA` (con *overshoot* enorme) | Aun convergiendo "por suerte", el primer paso es altamente inestable. |
| 3B | Newton-Raphson | `sin x + x²/20` | `x₀ = 1.7` | `FALLA_NO_CONVERGENCIA_EN_MAXIMO_ITERACIONES` | Cerca de un máximo local, `f' ≈ 0` y el iterado se va al infinito. |
| 4 | Bisección | `(x − 1.1)²(x − 2) − 0.01` | `[1, 3]` | `CONVERGENCIA_EXITOSA` (raíz hallada, **otras ocultas**) | Bisección no detecta multiplicidad ni casi-raíces sin cambio de signo. |

> **Conclusión general.** La elección del método **debe** estar guiada por el conocimiento previo del comportamiento de la función: convexidad, multiplicidad de raíces, presencia de máximos/mínimos locales y suavidad de la derivada. Ningún método es universal.

