function [ delta ] = KroneckerDelta( a,b )
%KRONECKERDELTA Just Kronecker Delta
%   If input args is equal return 1 else return 0
if(a==b)
    delta=1;
else
    delta=0;
end


end

