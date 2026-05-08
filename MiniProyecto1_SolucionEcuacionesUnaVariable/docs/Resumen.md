Voy a comparar el código base del profesor con la implementación del mini proyecto para extraer los pasos que se siguieron.

Read [](file:///home/jr_g/Develop/Numerical_methods/MiniProyecto1_SolucionEcuacionesUnaVariable/caso1_NewtonRaphson_CicloLimite_FuncionCubicaModificada.m)

Read [](file:///home/jr_g/Develop/Numerical_methods/MiniProyecto1_SolucionEcuacionesUnaVariable/caso4_Biseccion_TrampaRaizOmitida_PolinomioPerturbado.m)

## Qué pasó entre el código del profesor y el mini proyecto

En Algoritmos_ProfADonis tienes scripts directos que implementan los métodos para una sola función fija. En MiniProyecto1_SolucionEcuacionesUnaVariable hay dos capas:

1. metodo_biseccion_generico.m y metodo_newton_raphson_generico.m
   - Son la **base reusable**.
   - Extraen la lógica del algoritmo y la parametrizan con:
     - función objetivo
     - derivada (solo Newton)
     - intervalos / punto inicial
     - tolerancia
     - máximo de iteraciones
   - Además devuelven historial y estado de convergencia para graficar y analizar fallos.

2. Los casos `caso1_...`, `caso2_...`, `caso3_...`, `caso4_...`
   - Son los **experimentos específicos**.
   - Definen cada función concreta, los parámetros del problema y las gráficas.
   - Llaman al método genérico y luego muestran resultados visuales y diagnósticos.

---

## Pasos exactos para replicarlo sin usar IA

### 1. Identificar la lógica del profesor

Del profesor tienes, por ejemplo:

- en Biseccion_By_ProfAdonis.m
  - fórmula de `c = (a+b)/2`
  - evaluación de `f(c)`
  - comprobación de signo `f(a)*f(c) < 0`
  - actualización de `a` o `b`
  - condición de parada por `(b-a)/2 < tol`

- en NewtonRhapsonGeneral_By_ProfAdonis.m
  - fórmula `x_next = x_current - f(x)/f'(x)`
  - condición `abs(f_prime_val) < 1e-10`
  - error `abs(x_next - x_current)`
  - bucle `while error >= tolerance`

### 2. Convertir el código a una función genérica

Toma ese flujo y conviértelo en una función con parámetros en vez de valores fijos.

Para bisección:

- Crea archivo metodo_biseccion_generico.m
- Recibe:
  - `funcion_objetivo`
  - `a`
  - `b`
  - `tolerancia`
  - `maximo_numero_iteraciones`
- Reemplaza expresiones directas como `c^3 - 2*c - 5` por `funcion_objetivo(c)`
- Añade:
  - verificación de Bolzano al inicio
  - historial de iteraciones
  - estado de convergencia final

Para Newton:

- Crea metodo_newton_raphson_generico.m
- Recibe:
  - `funcion_objetivo`
  - `derivada_funcion_objetivo`
  - `valor_inicial_x0`
  - `tolerancia`
  - `maximo_numero_iteraciones`
  - `umbral_minimo_derivada`
  - `umbral_maximo_magnitud_iterado`
- Reemplaza `x_current.^3 - 2*x_current - 5` y `3*x_current.^2 - 2` por las funciones
- Mantén la misma lógica de bucle y de cálculo de `x_next`
- Añade diagnósticos extras:
  - derivada muy pequeña
  - divergencia explosiva
  - ciclo límite de periodo 2

### 3. Registrar el historial de la iteración

Ese es un paso clave que diferencia el mini proyecto del código base:

- Guarda cada iteración en una fila
- Para Bisección: `[k, a_k, b_k, c_k, f(a_k), f(b_k), f(c_k), error_k]`
- Para Newton: `[k, x_k, f(x_k), f'(x_k), x_{k+1}, error_k]`

Esto te permite luego graficar:
- iterados sobre la curva
- tangentes de Newton
- puntos medios de bisección
- evolución del error

### 4. Escribir los casos concretos

Cada caso hace esto:

- definir `funcion_objetivo` con `@(...)`
- definir `derivada_funcion_objetivo` si es Newton
- fijar `x0`, `a`, `b`, `tol`, `max_iter`
- llamar al método genérico
- imprimir el resultado
- graficar con los datos del historial

Ejemplos concretos:

- caso1_NewtonRaphson_CicloLimite_FuncionCubicaModificada.m
  - función `@(x) x.^3 - 5.*x`
  - derivada `@(x) 3.*x.^2 - 5`
  - `x0 = 1`
  - llama a `metodo_newton_raphson_generico`
  - traza la curva, los puntos `x_k` y las rectas tangentes

- caso4_Biseccion_TrampaRaizOmitida_PolinomioPerturbado.m
  - función `@(x) (x - 1.1).^2 .* (x - 2) - 0.01`
  - intervalo `[1, 3]`
  - llama a `metodo_biseccion_generico`
  - comprueba `f(a) * f(b) < 0`
  - grafica la "zona oculta" y los puntos medios

### 5. Agregar explicación y documentación

El mini proyecto incluye:
- comentarios analíticos arriba del script
- diagnóstico final del fallo
- títulos y leyendas en las figuras

Eso es lo que convierte el algoritmo en “resultado final”:
- no solo se calcula la raíz
- sino que se explica por qué falla o por qué converge

---

## Cómo replicar el proceso paso a paso

Si quieres hacerlo tú mismo, sigue estos pasos en orden:

1. Abre el script del profesor y entiende cada línea.
2. Copia el cuerpo del bucle y conviértelo en función con argumentos.
3. Sustituye los valores de la función por `funcion_objetivo(...)`.
4. Añade comprobaciones genéricas:
   - `f(a)*f(b) < 0` para bisección
   - `|f'(x)| < umbral` para Newton
5. Agrega una matriz `historial_iteraciones` para guardar cada paso.
6. Devuelve un `estado_convergencia` claro en la función.
7. Crea un script por cada caso específico:
   - define la función concreta
   - define parámetros
   - llama a la función genérica
   - grafica usando el historial
8. Añade texto descriptivo y títulos en las gráficas.
9. Guarda las imágenes con `print(..., '-dpng')` si quieres resultados exportables.
10. Prueba con el ejecutar_todos_los_casos_del_miniproyecto.m para verificar todo.

---

## Resumen práctico

- Algoritmos_ProfADonis = algoritmo directo y específico
- `metodo_*_generico.m` = refactorización reusable y robusta
- `caso*.m` = aplicación puntual + visualización + explicación
