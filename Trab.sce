function [NXYZ] = rk4(inicial,final,f0,f1,f2,Dn)
    N(1)= inicial//onde inicial é primeiro valor a ser avaliado
    X(1)= f0//f0 é o valor inicial da função f
    Y(1)= f1//f1 é o valor inicial da função f'
    Z(1)= f2//f2 é o valor inicial da função f'' 
    n=(final-inicial)/Dn // variável que determina total de iterações do for
    //Dn é a variação em n
    //final é o ultimo valor a ser avaliado
    for k= 1:n
      nk = N(k)
      xk = X(k)
      yk = Y(k)
      zk = Z(k)
        
      k1 = func1(nk, xk, yk, zk)
      k11 = func2(nk, xk, yk, zk)
      k111 = func3(nk, xk, yk, zk)
        
      k2 = func1(nk + Dn/2, xk + (k1/2)*Dn, yk + (k11/2)*Dn, zk + (k111/2)*Dn)
      k22 = func2(nk + Dn/2, xk + (k1/2)*Dn, yk + (k11/2)*Dn, zk + (k111/2)*Dn)
      k222 = func3(nk + Dn/2, xk + (k1/2)*Dn, yk + (k11/2)*Dn, zk + (k111/2)*Dn)
        
      k3 = func1(nk + Dn/2, xk + (k2/2)*Dn, yk + (k22/2)*Dn, zk + (k222/2)*Dn)
      k33 = func2(nk + Dn/2, xk + (k2/2)*Dn, yk + (k22/2)*Dn, zk + (k222/2)*Dn)
      k333 = func3(nk + Dn/2, xk + (k2/2)*Dn, yk + (k22/2)*Dn, zk + (k222/2)*Dn)
        
      k4 = func1(nk + Dn, xk + k3*Dn, yk + k33*Dn, zk + k333*Dn)
      k44 = func2(nk + Dn, xk + k3*Dn, yk + k33*Dn, zk + k333*Dn)
      k444 = func3(nk + Dn, xk + k3*Dn, yk + k33*Dn, zk + k333*Dn)
        
      X(k+1) = X(k) + ((k1 + 2*k2 + 2*k3 + k4)/6)*Dn
      Y(k+1) = Y(k) + ((k11 + 2*k22 + 2*k33 + k44)/6)*Dn
      Z(k+1) = Z(k) + ((k111 + 2*k222 + 2*k333 + k444)/6)*Dn
      N(k+1) = N(k) + Dn
    end

    mprintf("N \t X \t\t Y \t\t Z\n");
    for i=1:length(X)
         mprintf("%.2f \t %f \t %f \t %f \n",N(i), X(i), Y(i), Z(i));
    end
    
    clf

    plot(N, X, 'b')// gráfico do X em azul
    plot(N, Y, 'r')// gráfico do Y em vermelho
    plot(N, Z, 'g')// gráfico do Z em verde
    xgrid
    legend('X','Y', 'Z', 2)
    xlabel('$N$', "fontsize", 4)
    ylabel('$FUNÇÕES$')
    xtitle('ESCOAMENTO DO TIPO CAMADA LIMITE')
    NXYZ = [N X Y Z]
endfunction

funcprot(0)
function [fxn]= func1(n, x, y ,z)//Derivada de X em n
    fxn= y
endfunction

function [fyn]= func2(n, x ,y, z)//Derivada de Y em n
    fyn= z
endfunction

function [fzn]= func3(n, x, y, z)//Derivada de Z em n
    fzn= -x*z-0.25*(1-y*y)
endfunction

inicio = 0
fim = 6
f0 = 0 //Condição inicial 1
f1 = 0 //Condição inicial 2
f2 = 0.64 //Condição inicial 3
Delta_n = 0.01

rk4(inicio,fim,f0,f1,f2,Delta_n)
