classdef DiffractedHarmIsolRes
    %DIFFRACTEDHARMISOLRES Calculating nonresonance harmonics
    
    
    properties
        %   h_N - array 1 by 20, 10th harmonic corresponds to 0th
        %   R - Frensel coefficient reflection
        %It's not allowed define h_N and R as number if they will be
        %symbols in building functional
        h_N;%h_N=zeros(1,20);
        R=0;
    end
    
    methods
        function obj=calcNonRes(obj,r,h_r,xi,xi_0,beta)
            if(isnumeric(xi(1)))
                h=zeros(1,20);
            end
            for N=-9:10
                %   0th harmonics, in this calculation 10th
                if(N==0)
                    obj.R=(beta(N+10)-xi_0)/(beta(N+10)+xi_0);
                     h(N+10)=obj.R-xi(-r+10)*h_r/(beta(N+10)+xi_0);
                else
                    if(N-r>-10&&N-r<11)
                      xitmp=xi(N-r+10);
                    else
                        xitmp=0;
                    end
                    h(N+10)=-(xi(N+10)+xitmp*h_r)/(beta(N+10)+xi_0);
                end
            end
            obj.h_N=h;
        end
    end
    
end

