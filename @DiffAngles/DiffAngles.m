classdef DiffAngles
    %DIFFANGLES Angles of diffracted spectra
    
    properties
        beta;
        d;
    end
    
    methods
        function obj=DiffAngles(incl_angle,wavelength,grat_period)
            obj.d=grat_period;
            obj.beta=obj.getBetas(incl_angle,wavelength,grat_period);
        end
        %   Calculate beta[-10...10], incl_angle - angle of inclination, wavelength -
        %   wavelength of falling wave, grat_period - period of grating
        %   (d), N - number of diffracted srectrum
        %   
        %   beta[] is array beta_0 correspond to beta(10) because in matlab
        %   array index starts from 1
        function bt=getBetas(~,incl_angle,wavelength,grat_period)
            bt=zeros(1,20);
            for N=-9:10 
                bt(N+10)=sqrt(1-(sin(incl_angle*pi/180)+N*wavelength/grat_period)^2);%    Input incl_angle in degree, wavelength in nm, grat_period in nm
            end
        end
    end
    
end

