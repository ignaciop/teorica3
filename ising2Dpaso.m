function [S,dE,dM] = ising2Dpaso(S,beta)
    dM = 0;
    for a=1:length(S)*length(S)
        indices = randint(1,2,1,length(S));
        i = indices(1); j = indices(2);
            
        i1 = mod(i,length(S)) + 1;
        j1 = mod(j,length(S)) + 1;
        i2 = mod(i + length(S) - 2,length(S)) + 1;
        j2 = mod(j + length(S) - 2,length(S)) + 1;
           

        E_old = -S(i,j)*(S(i1,j)+S(i2,j)+S(i,j1)+S(i,j2));
        E_new = S(i,j)*(S(i1,j)+S(i2,j)+S(i,j1)+S(i,j2));

        dE = E_new - E_old;
        
        if ((dE <= 0) || (rand() < exp(-beta*dE)))
            S(i,j) = -S(i,j);
            dM = dM + 2*S(i,j);
        end
    end            
end
