function [S,dE,dM] = ising2Dpaso(S,beta)
    dM = 0;
    dE = 0;
    
    %Realiza el paso para cada spin de S
    for a=1:length(S)*length(S)
        
        %Elijo los indices i,j al azar con la funcion auxiliar definida
        indices = randint(1,2,1,length(S));
        i = indices(1); j = indices(2);
        
        %Considero los indices de los spines vecinos al S(i,j)
        iup = mod(i - 1 - 1, length(S)) + 1;
        idown = mod(i + 1 - 1, length(S)) + 1;
        jleft  = mod(j - 1 - 1, length(S)) + 1;
        jright = mod(j + 1 - 1, length(S)) + 1;
           
        %Calculo la diferencia de energia al cambiar el spin S(i,j)
        E_old = -S(i,j)*(S(iup,j)+S(idown,j)+S(i,jleft)+S(i,jright));
        E_new = S(i,j)*(S(iup,j)+S(idown,j)+S(i,jleft)+S(i,jright));
        

        dEt = E_new - E_old;
        
        %Aplico el criterio de eleccion y guardo en las variables
        %correspondientes dM y dE; actualizo S(i,j)
        if ((dEt <= 0) || (rand() < exp(-beta*dEt)))
            S(i,j) = -S(i,j);
            dM = dM + 2*S(i,j);
            dE = dE + dEt;
        end
    end            
end
