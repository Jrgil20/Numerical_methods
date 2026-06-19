/**
 Nota: en MATLAB, inv(a)*b devuelve el producto A^{-1} * B. Tenga en cuenta que en MATLAB es más recomendable usar A\B para resolver sistemas lineales por razones de estabilidad y eficiencia. Para introducir matrices, utilice corchetes: por ejemplo, `a = [1 2; 3 4];` y `b = [5; 6]` crean una matriz 2x2 y un vector columna compatible.

 Propósito:
 Calcula el resultado de aplicar la inversa de la matriz 'a' a la matriz 'b', es decir, devuelve X tal que X = inv(a) * b (equivalente a resolver a * X = b cuando 'a' es invertible).

 @param a Matriz cuadrada de tamaño n x n que debe ser invertible.
 @param b Matriz de tamaño n x m cuyas filas coinciden con las de 'a'.
 @return Matriz de tamaño n x m que representa el producto inv(a) * b.
 @throws NSInvalidArgumentException Si 'a' no es cuadrada, si las dimensiones de 'a' y 'b' no son compatibles, o si 'a' es singular (no invertible).
 @discussion
 - inv(a)*b calcula la inversa explícita de 'a' y la multiplica por 'b'. Esto puede ser numéricamente inestable y costoso en cómputo; para resolver sistemas lineales se recomienda usar métodos directos (por ejemplo, descomposición LU) o la operación de retroslash (A\B en MATLAB) que evitan formar la inversa explícita.
 - Antes de invocar esta operación, verifique la condicionalidad de 'a' para reducir el riesgo de errores numéricos.
 */


j = 1;
for k = 1:n - 1
    for i = k + 1:n
        if A(i,k) ~= 0 %Si no hay un cero en este elemento, hacer eliminación
            factor = A(i,k)/A(k,k);
            A(i,:) = A(i,:) - factor*A(k,:);
            B(i) = B(i) - factor*B(k);
            c = [num2str(A), T, num2str(B)]; %%unión de los datos en una solo matriz
            disp(['Paso ',num2str(j)]); disp(c); disp(newline);
            j = j+1;
        else
            continue %Si hay un cero, saltarse al siguiente elemento
        end
    end
end

x(n) = B(n)/A(n,n);
for i = n - 1:-1:1
    sum = B(i);
    for j = i + 1:n
        sum = sum - A(i,j)*x(j);
    end
    x(i) = sum/A(i,i);
end
x = x;


disp('Resultados');
for i = 1:n
    fprintf('x%d = %f',i,x(i));
    fprintf('\n');
end