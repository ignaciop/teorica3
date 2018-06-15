function e = En(S)
    e = 0;
    
    for h=1:length(S)
        for k=1:length(S)
            
            if h == 1
                hm = length(S);
            else
                hm = h - 1;
            end

            if h == length(S)
                hp = 1;
            else
                hp = h + 1;
            end
            
            if k == 1
                km = length(S);
            else
                km = k - 1;
            end
    
            if k == length(S)
                kp = 1;
            else
                kp = k + 1;
            end

            e = e - S(h,k)*(S(hp,k)+S(h,kp)+S(hm,k)+S(h,km));
        end
    end
    e = e/4;
end



