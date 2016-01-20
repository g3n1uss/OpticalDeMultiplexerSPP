function [ grating ] = BuildGrating( u,psi,xi0,t )
%BUILDGRATING Construct the grating knowing the amplitudes and phases of
%various harmonics
%   The modulated part of the grating is given by xi_n=i u_n exp(i psi_n),
%   where u_{-n}=u_n, psi_{-n}=-psi_n
grating=0;
for k=11:length(u)
    grating=2*(u(k)*cos(psi(k)+2*pi*(k-10)*t))+grating;
end
grating=grating+imag(xi0);



end

