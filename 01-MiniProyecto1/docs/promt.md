# Prompt Estructurado: Refactorización a Arquitectura de Dos Capas para Métodos Numéricos

**Rol:** Actúa como un Ingeniero de Software especializado en MATLAB y cálculo numérico.

**Contexto y Objetivo:**
Necesito refactorizar scripts monolíticos de métodos numéricos (creados originalmente por el Prof. Adonis para una sola función fija) en una arquitectura modular de dos capas.

1. **Capa Base (Reusable):** Funciones genéricas parametrizadas que extraen la lógica del algoritmo.
2. **Capa de Experimentos (Casos):** Scripts que definen funciones concretas, inyectan parámetros, grafican y diagnostican.

El objetivo no es solo calcular la raíz, sino registrar el paso a paso detallado para poder explicar visual y textualmente por qué el método converge, diverge o falla.

**Enunciado Original del Problema (Fundamento Teórico):**

> Análisis de fallas de los Métodos de Newton y Bisección.
> El principal desafío al buscar raíces numéricas radica en que ningún método es infalible; mientras la bisección es "lenta pero segura", el de Newton-Raphson es "rápido pero arriesgado". La bisección falla principalmente por su incapacidad de detectar raíces donde la función no cruza el eje X (raíces de multiplicidad par), además de ser extremadamente tediosa al requerir un intervalo con cambio de signo obligatorio. Por otro lado, Newton-Raphson colapsa si el valor inicial está lejos de la solución o si se topa con una pendiente horizontal (derivada cero), lo que provoca que el algoritmo se dispare hacia el infinito o quede atrapado en un ciclo sin fin. En este sentido, es vital entender que la bisección puede tardar demasiado en converger, mientras que Newton-Raphson, aunque potente, es caprichoso: si la función tiene curvas muy pronunciadas o si la raíz es múltiple, su velocidad se desploma y puede entregar resultados erróneos. Mientras que el método de Bisección sufre por su rigidez e ineficiencia, Newton-Raphson es vulnerable a la forma geométrica de la función y a la mala elección del punto de partida.

---

### **HAZ ESTO (Instrucciones de Implementación Detallada)**

**1. Desarrolla la Capa 1: Métodos Genéricos (Base Reusable)**
Crea dos funciones genéricas que reciban la función objetivo (y su derivada, si aplica) como *function handles* (`@`), además de tolerancias y límites de iteración.

* **Para Bisección (`metodo_biseccion_generico.m`):**
* Implementa la validación inicial del Teorema de Bolzano ($f(a) \cdot f(b) < 0$).
* Aplica la fórmula clásica $c = \frac{a+b}{2}$ y la evaluación $f(c)$.
* Actualiza los límites basándote en el cambio de signo.
* Utiliza como criterio de parada: $\frac{b-a}{2} < tol$ o alcanzar el máximo de iteraciones.


* **Para Newton-Raphson (`metodo_newton_raphson_generico.m`):**
* Aplica la fórmula: $x_{i+1} = x_i - \frac{f(x_i)}{f'(x_i)}$.
* Criterio de parada del bucle: $|x_{i+1} - x_i| < tol$.
* Implementa validaciones críticas que aborten o notifiquen fallos:
* Derivada demasiado pequeña: $|f'(x_i)| < \text{umbral\_minimo\_derivada}$.
* Divergencia explosiva por rebasar un `umbral_maximo_magnitud_iterado`.





**2. Implementa el Registro de Historial (Matriz de Traza)**
Dentro de cada bucle `while/for`, debes guardar el estado exacto de cada iteración en una matriz o tabla para su posterior análisis. Respeta estrictamente esta estructura de columnas:

* **Historial Bisección:** `[k, a_k, b_k, c_k, f(a_k), f(b_k), f(c_k), error_k]`
* **Historial Newton:** `[k, x_k, f(x_k), f'(x_k), x_{k+1}, error_k]`

**3. Desarrolla la Capa 2: Scripts de Casos Específicos**
Escribe scripts independientes que consuman las funciones genéricas para evaluar los siguientes cuatro experimentos particulares. Debes incluir demostraciones analíticas en los comentarios y ejecución experimental:

* **Caso 1 (Newton - Ciclo Límite):** Función $f(x) = x^3 - 5x$ con $x_0 = 1$. Demuestra analítica y experimentalmente que el método entra en un ciclo límite de período 2 oscilando entre 1 y -1.
* **Caso 2 (Newton - Raíz Oscilante):** Función $f(x) = x^{1/3}$ (manejar como `sign(x).*abs(x).^(1/3)` en MATLAB para evitar números complejos). Demuestra por qué falla al intentar hallar $x=0$ con un iterado inicial distinto de cero.
* **Caso 3 (Newton - Máximo Local):** Función $f(x) = \sin(x) + \frac{x^2}{20}$ con $x_0 = 1.08216$. Demuestra que el método colapsa en la segunda iteración por presencia de un máximo local (derivada tiende a cero).
* **Caso 4 (Bisección - Trampa Raíz Omitida):** Sistema físico descrito por $f(x) = (x - 1.1)^2 \cdot (x - 2) - 0.01$ en el intervalo $[1, 3]$. Verifica el cambio de signo y analiza por qué el resultado es un fallo desde el punto de vista del diseño.

**4. Genera Diagnóstico y Visualización**
Cada script de caso (Capa 2) debe tomar el "historial" devuelto por la función genérica y generar:

* Gráficas de la curva principal superponiendo los iterados.
* En Newton: Traza las rectas tangentes evaluadas en cada paso.
* En Bisección: Marca la "zona oculta" y la progresión de los puntos medios.
* Imprime en consola un "Estado de Convergencia" y un bloque de comentarios analíticos que explique verbalmente por qué el algoritmo actuó como lo hizo.

---

### **ENTREGA ESTO (Artefactos Esperados)**

Genera el código completo, comentado y listo para ejecutar en MATLAB para los siguientes 6 archivos:

1. `metodo_biseccion_generico.m`: Con parámetros `(funcion_objetivo, a, b, tolerancia, max_iter)`.
2. `metodo_newton_raphson_generico.m`: Con parámetros `(funcion_objetivo, derivada, x0, tolerancia, max_iter, umbrales_de_fallo)`.
3. `caso1_NewtonRaphson_CicloLimite_FuncionCubicaModificada.m`.
4. `caso2_NewtonRaphson_RaizOscilante_FuncionRaizCubica.m`.
5. `caso3_NewtonRaphson_TrampaMaximoLocal_FuncionSenoMasCuadratica.m`.
6. `caso4_Biseccion_TrampaRaizOmitida_PolinomioPerturbado.m`.

Asegúrate de que los scripts de casos incluyan las funciones de ploteo (ej. `plot`, `fplot`, `scatter`) y la exportación de gráficos usando `print(..., '-dpng')` o similar.
