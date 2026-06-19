# Métodos Numéricos — Repositorio Centralizado

Colección completa de scripts **Octave/MATLAB** para el curso de **Métodos Numéricos**.
Organizado en **capas**: desde fundamentos y mini-proyectos hasta parciales.

## 📁 Estructura del repositorio

```
00-Fundamentos/              Algoritmos básicos sin parcial
├── 01-Sistemas-Lineales/    Gauss, Jacobi, Gauss-Seidel
├── 02-Ecuaciones-NoLineales Bisección, Newton, Secante
├── 03-Interpolacion/        Lagrange
├── 04-Integracion-Diferenciacion/  (reservado)
└── 05-EDO/                  Euler, Runge-Kutta

01-MiniProyecto1/            Mini-proyecto 1: Newton vs Bisección
├── algoritmos/
├── casos/
├── docs/
└── salidas/

02-Parcial1/                 Primer examen parcial
└── Scripts demostrativos de Newton y Babylonia

03-Parcial2/                 Segundo examen parcial (antiguo)
└── Ajustes, interpolación, integración

04-Parcial2-Adonais/         Segundo parcial (interactivo, paso a paso)
├── t1_interpolacion_*.m     Interpolación
├── t2_spline_cubico.m       Trazadores
├── t3_minimos_cuadrados.m   Ajuste de curvas
├── t4_diferenciacion.m      Diferenciación
├── t5_*.m                   Integración
├── t6_*.m                   EDO
├── run_todos.m              Menú interactivo
├── README.md                Instrucciones
└── REVIEW.md                Validación numérica

docs/                        Documentación general
└── GUIA_TEMAS.md
```

## 🚀 Inicio rápido

### Opción 1: Menú interactivo (recomendado para examen)

```bash
cd 04-Parcial2-Adonais
octave run_todos
```

Elige el tema que necesites. Cada script muestra **todos los pasos intermedios**.

### Opción 2: Script individual

```bash
cd 04-Parcial2-Adonais
octave t5_simpson13  # por ejemplo
```

### Opción 3: Fundamentos (desarrollo/estudio)

```bash
cd 00-Fundamentos/01-Sistemas-Lineales
octave ejemplo_GaussJacobi_paso_a_paso
```

## 📚 Temario cubierto

### Fundamentos (`00-Fundamentos/`)

| Tema | Archivos | Descripción |
|------|----------|-----------|
| **Sistemas Lineales** | `gauss*.m`, `GaussJacobi*.m`, `GaussSeidel*.m` | Eliminación gaussiana, métodos iterativos |
| **Ecuaciones No Lineales** | `biseccion*.m`, `newton*.m`, `secante*.m` | Métodos de búsqueda de raíces |
| **Interpolación** | `lagrange*.m` | Interpolación polinomial |
| **EDO** | `Runge-Kutta.m`, `edo_ejemplos.m` | Métodos de integración de ODEs |

### Mini-Proyecto 1 (`01-MiniProyecto1/`)

Estudio detallado de **Newton vs Bisección**:
- Análisis de casos de fallo (ciclo límite, raíz oscilante, máximo local, raíz omitida)
- Comparativa de convergencia
- Documentación completa

### Parciales

| Carpeta | Enfoque | Scripts |
|---------|---------|---------|
| **02-Parcial1** | Raíces de ecuaciones | Newton-Raphson, Babylonia, error |
| **03-Parcial2** | Integración, interpolación, ajuste | Simpson, Lagrange, mínimos cuadrados |
| **04-Parcial2-Adonais** | **Interactivo, paso a paso** | Todos los 6 temas con verificación nativa |

## 🎯 Para el examen

**→ Usa la carpeta `04-Parcial2-Adonais/`**

- ✅ Scripts listos para copiar-pegar datos y resolver
- ✅ Cada paso se imprime en pantalla
- ✅ Verificación automática con comandos nativos de Octave
- ✅ Gráficas generadas
- ✅ Flag `PASO_A_PASO` para estudiar interactivamente

Ver [04-Parcial2-Adonais/README.md](04-Parcial2-Adonais/README.md).

## 📖 Documentación

- [PLAN.md](04-Parcial2-Adonais/PLAN.md) — Diseño y estructura de los scripts
- [REVIEW.md](04-Parcial2-Adonais/REVIEW.md) — Validación numérica completa
- [GUIA_TEMAS.md](docs/GUIA_TEMAS.md) — Resumen de fórmulas y comandos

## 🔍 Buscar un tema específico

| Quiero... | Carpeta | Archivo |
|-----------|---------|---------|
| Resolver Ax=b | `00-Fundamentos/01-Sistemas-Lineales/` | `gauss*.m`, `GaussJacobi*.m` |
| Hallar raíces | `00-Fundamentos/02-Ecuaciones-NoLineales/` | `biseccion*.m`, `newton*.m` |
| Interpolar puntos | `00-Fundamentos/03-Interpolacion/` | `lagrange*.m` |
| Integrar una función | `04-Parcial2-Adonais/` | `t5_*.m` |
| Resolver una EDO | `04-Parcial2-Adonais/` | `t6_*.m` |
| Ajustar datos | `04-Parcial2-Adonais/` | `t3_minimos_cuadrados.m` |
| Diferenciar numéricamente | `04-Parcial2-Adonais/` | `t4_diferenciacion.m` |

## ⚙️ Requisitos

- **Octave 4.2+** (o MATLAB 2016b+)
- Sin dependencias externas (solo comandos nativos)

## 🤝 Créditos y referencias

- Prof. Adonis: Métodos para raíces, sistemas lineales
- Ejemplos didácticos: paso a paso con tablas y gráficas
- Validación numérica de Parcial2-Adonais: réplica de algoritmos en Python

## 📝 Notas de desarrollo

- Cambio reciente: Reorganización de carpetas (Parcial1, Parcial2) y creación de `00-Fundamentos/`
- Última mejora: Robustez en integración/EDO (`linspace` en lugar de `:`)
- Todos los scripts validados contra valores exactos (ver [REVIEW.md](04-Parcial2-Adonais/REVIEW.md))

---

**Última actualización:** 2026-06-19 | **Estado:** Reorganizado y documentado ✅
