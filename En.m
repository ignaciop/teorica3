function e = En(S)
    e = 0;
    
    for i=1:length(S)
        for j=1:length(S)
            iup = mod(i - 1 - 1, length(S)) + 1;
            jright = mod(j + 1 - 1, length(S)) + 1;

            e = e - S(i,j)*(S(iup,j)+S(i,jright));
        end
    end
end



