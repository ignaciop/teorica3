function e = En(S)
    e = 0;
    
    for i=1:length(S)
        for j=1:length(S)
            
            if i == 1
                im = length(S);
            else
                im = i - 1;
            end

            if i == length(S)
                ip = 1;
            else
                ip = i + 1;
            end
            
            if j == 1
                jm = length(S);
            else
                jm = j - 1;
            end
    
            if j == length(S)
                jp = 1;
            else
                jp = j + 1;
            end

            e = e - S(i,j)*(S(ip,j)+S(i,jp)+S(im,j)+S(i,jm));
        end
    end
    e = e/4;
end



