classdef SurfaceMaterial
    %MATERIAL Object material
    %   Object have the following properties:
    %   plasma frequency \omega_p
    %       \gamma
    
    properties
        c=3*10^8;% speed of light
        plasma_freq=13.8*10^15;% plasma frequency, default value for gold
        absorption=10^14; % absorption in Drude Lorentz formula, default value for gold
        wavelength;
        freq; % angular frequency
        epsilon; % dielectric function
        xi0; % constant value of impedance
    end
    
    methods
        %   Constructor - build material (find epsilon)
        function obj=SurfaceMaterial(lambda,omega_p,gamma)
            obj.wavelength=lambda;
            obj.plasma_freq=omega_p;
            obj.absorption=gamma;
            obj.freq=2*pi*obj.c/obj.wavelength*10^9; % omega=2pi c/lambda, 10^9 factor comes from the fact that wavelength is in nanometers
            obj.epsilon=obj.getEpsilon(lambda); % Drude-Lorentz model
            obj.xi0=1/sqrt(obj.epsilon);
        end
        
        function eps=getEpsilon(obj,lambda)
            freqtmp=2*pi*obj.c/lambda*10^9;
            eps=1-obj.plasma_freq^2/(freqtmp^2+1i*freqtmp*obj.absorption); 
        end

    end
    
end

