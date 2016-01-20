function [D,V]=BuildEqSystem(beta,xi,xi0)
D=zeros(20,20);
V=zeros(20,1);
for m=-9:10
    for l=-9:10
        if(m==l)
            D(m+10,l+10)=(beta(m+10)+xi0);
        elseif(m-l+10>20||m-l+10<1)
            D(m+10,l+10)=0;
        else
            D(m+10,l+10)=xi(m-l+10);
        end
        
    end
    V(m+10)=(beta(10)-xi0)*KroneckerDelta(m+10,10)-xi(m+10);
end
end

