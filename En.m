function e = En(S)
    e = 0;
    
    for i=1:length(S)
        for j=1:length(S)
            
            %Para cada spin, considero el spin vecino de arriba (fila i-1)
            %el de su derecha (columna j+1)
            iup = mod(i - 1 - 1, length(S)) + 1;
            jright = mod(j + 1 - 1, length(S)) + 1;

            e = e - S(i,j)*(S(iup,j)+S(i,jright));
        end
    end
end



