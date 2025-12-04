tol=
A=
b=
n = lenghth(b);
x0 = ones(n,1);
x1 = zeros(n,1);
iter = 0;
c = x1';
while (norm(x0-x1)>tol)
    x0 = x1;
    for i=1:n
        suma1 = 0;
        suma2 = 0;
        for j=1:n
            if (j>i)
                suma1 = suma1 + A(i,j)*x0(j);
            end
            if (j<i)
                suma1 = suma1 + A(i,j)*x1(j);
            end
        end
        x1(i) = (b(i)-suma1-suma2)/A(i,i);
    end

    iter = iter + 1;
    c = [c; x1'];
end
disp('Numero de iteraciones:');
disp(iter);
disp('Aproximacion de la solucion:');
disp(x1);
disp('Tabla de iteraciones:');
disp(comprobacion);
A^-1*b
