function e = En(S)
    e = 0;
    
    for i=1:length(S)
        for j=1:length(S)
            ip = mod(i,length(S)) + 1;
            jp = mod(j,length(S)) + 1;

            e = e - S(i,j)*(S(ip,j)+S(i,jp));
        end
    end
end



