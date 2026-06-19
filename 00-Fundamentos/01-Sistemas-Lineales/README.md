# Sistemas Lineales — Resolución de Ax = b

Métodos para resolver sistemas de ecuaciones lineales.

## 📋 Scripts

| Archivo | Método | Tipo | Descripción |
|---------|--------|------|-----------|
| `gauss-1.m` | Eliminación Gaussiana | Directo | Reducción a matriz triangular superior |
| `gauss-2.m` | Eliminación Gaussiana | Directo | Variante con detalles |
| `gauss_jordan-1.m` | Gauss-Jordan | Directo | Reducción a matriz identidad |
| `gauss_jordan-2.m` | Gauss-Jordan | Directo | Variante con steps |
| `Gauss_EliminacionAdelantesustituciinAtras.m` | Gauss + sustitución | Directo | Implementación completa |
| `GaussJacobi.m` | Método de Jacobi | Iterativo | Convergencia lenta, simple |
| `GaussJacobi_comandos_clave.m` | Jacobi con instrucciones | Iterativo | Versión educativa |
| `ejemplo_GaussJacobi_paso_a_paso.m` | Jacobi paso a paso | Iterativo | **Recomendado para aprender** |
| `GaussSeidel.m` | Método de Gauss-Seidel | Iterativo | Convergencia más rápida que Jacobi |
| `GaussSeidel_comandos_clave.m` | Gauss-Seidel clave | Iterativo | Versión clave |
| `ejemplo_GaussSeidel_paso_a_paso.m` | Gauss-Seidel paso a paso | Iterativo | **Recomendado para aprender** |
| `EcLineal_Gaus-Seidel.m` | Sistema con Gauss-Seidel | Iterativo | Caso completo |

## 🎯 Por nivel de dificultad

### Principiante
- `ejemplo_GaussJacobi_paso_a_paso.m` ← **Empieza aquí**
- `ejemplo_GaussSeidel_paso_a_paso.m`

### Intermedio
- `gauss-1.m`, `gauss-2.m`
- `GaussJacobi.m`, `GaussSeidel.m`

### Avanzado
- `gauss_jordan-1.m`, `gauss_jordan-2.m`
- `Gauss_EliminacionAdelantesustituciinAtras.m`

## 💡 Comparación de métodos

| Método | Tipo | Velocidad | Convergencia | Uso |
|--------|------|-----------|--------------|-----|
| Gauss | Directo | Rápido | Garantizada | Sistemas pequeño-medianos |
| Gauss-Jordan | Directo | Más lento | Garantizada | Encontrar inversa, sistemas pequeños |
| Jacobi | Iterativo | Lenta | Condicionada | Sistemas muy grandes, paralelos |
| Gauss-Seidel | Iterativo | Rápida | Mejor que Jacobi | Sistemas grandes, densos |

## 🚀 Inicio rápido

```octave
% Método directo (simple)
octave gauss-1.m

% Método iterativo (didáctico)
octave ejemplo_GaussJacobi_paso_a_paso.m

% Comparativa
octave EcLineal_Gaus-Seidel.m
```

---

**Siguiente:** [02-Ecuaciones-NoLineales/](../02-Ecuaciones-NoLineales/)
