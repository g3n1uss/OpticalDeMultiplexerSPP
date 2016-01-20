classdef Functional
    %FUNCTIONAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        betas;
        xi0=0;
        uinit; % properties of a grating from analytical solution
        ufinal; % properties of a grating after minimizing
        psifinal;
        res; % resonance spectra
        s; % desired flux distribution
    end
    
    methods
        function obj=Functional(xi0,beta,uinit,r,s)
            obj.xi0=xi0;
            obj.betas=beta;
            obj.uinit=uinit;
            obj.res=r;
            obj.s=s;
        end
        % Evaluate the value of the functional with given xi
        function func_value=evaluate(obj,xi)
            % values of D and V
            D=zeros(20,20);
            V=zeros(20,1);
            for m=-9:10
                for l=-9:10
                    if(m==l)
                        D(m+10,l+10)=(obj.betas(m+10)+obj.xi0);
                    elseif(m-l+10>20||m-l+10<1)
                        D(m+10,l+10)=0;
                    else
                       D(m+10,l+10)=xi(m-l+10); 
                    end
                    
                end
                V(m+10)=(obj.betas(10)-obj.xi0)*KroneckerDelta(m+10,10)-xi(m+10);
            end
            
            Stmp=zeros(1,20);
            h_nonres=D\V;
            for N=1:20
                Stmp(N)=obj.betas(N)*abs(h_nonres(N)')^2/obj.betas(10);
            end
            func_value=0;
            for N=1:20
                if isreal(Stmp(N))
                    func_value=(obj.s(N)-Stmp(N))^2+func_value;
                end
            end
        end
        
        function step=chooseStep(obj,xiInit,xiStep)
            xi=zeros(1,length(xiInit));
            func0=obj.evaluate(xiInit);
            xi(:)=xiInit(:)+xiStep(:);
            steptmp1=xiStep;
            func1=obj.evaluate(xi);
            
            xi(:)=xi(:)-2*xiStep(:);
            steptmp2=-xiStep;
            func2=obj.evaluate(xi);
            
            if(func1<func0)
                step=steptmp1;
            elseif func2<func0
                step=steptmp2;
            else step=zeros(1,length(xiStep));
            end
            
        end
        
        function obj=Minimize(obj)
            xi=zeros(1,20);
            psi=zeros(1,20);
            xi(:)=1i*obj.uinit(:).*exp(1i*psi(:));
            %First of all choose step
            xitmp=xi;
            for i=1:abs(obj.res)%step along only essential harmonics, if we want step along all harmonics replace r by 9
                xiStep=zeros(1,20);
                xiStep(i+10)=1i*0.001;
                xiStep(10-i)=1i*0.001;
                step=obj.chooseStep(xitmp,xiStep);
                func1=obj.evaluate(xitmp);
                if imag(xitmp(i+10)+step(i+10))>0
                    xitmp=xitmp+step;
                    func2=obj.evaluate(xitmp);
                    while(func1>func2) & (imag(xitmp(i+10))>0)
                        func1=obj.evaluate(xitmp);
                        xitmp=xitmp+step;
                        func2=obj.evaluate(xitmp);
                    end
                end
            end
            obj.ufinal=imag(xitmp);
            
            %xi=xitmp;func=func2;
            
            %   Now we go along psi
            
            for i=1:abs(obj.res)%step along only essential harmonics, if we want step along all harmonics replace r by 9
                PsiStep=zeros(1,20);%At every step psiStep must be zero
                if i~=abs(obj.res)%phase of the resonance fourie-harmonic is equal null
                    PsiStep(i+10)=pi/180;
                    PsiStep(10-i)=-pi/180;
                    step=chooseStepPsi(xitmp,PsiStep,theta,lambda_res,d,s);
                    func1=obj.evaluate(xitmp);
                    xitmp(:)=xitmp(:).*exp(1i*step(:));
                    func2=obj.evaluate(xitmp);
                    while(func1>func2)
                        psi=psi+step;
                        func1=obj.evaluate(xitmp);
                        xitmp(:)=xitmp(:).*exp(1i*step(:));
                        func2=obj.evaluate(xitmp);
                    end
                end
            end
            
            obj.psifinal=psi;
            
        end
            
    end
    
end

