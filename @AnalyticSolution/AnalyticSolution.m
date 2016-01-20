classdef AnalyticSolution
    %ANALYTICSOLUTION Calculate the properties of a grating using the
    %analytical solution
    %   Detailed explanation goes here
    
    properties
        u;
    end
    
    methods
        function obj=AnalyticSolution(outs,xi_0,s,beta,r)
            %   The constructor creates the empty array for u, betas and xi0.
            obj.u=obj.getGrating(outs,xi_0,s,beta,r);          
        end
        
       
        
        function utmp= getGrating(~,outs,xi0, s, beta, r )
            %ANALYTICSOLUTION Find u_N knowing s, xi_0, beta_N, r. Solution of inverse problem

            %   u-vector. 11th component corresponds u_1. Half of vector is empty,
            %   but it's comfortable make this vector with 20 elements to
            %   correspond other quatities like s_N ,h_N, beta_N
            utmp=zeros(1,outs);
    
            %   Find additional quantity
            %   X=(sum(s)-s(10))*real(xi_0)/(1-sum(s));
            %   Calculate u_r
            %u(r+10)=sqrt(beta(10)*(real(xi_0)+X)*(1-sqrt(s(10)))/(1+sqrt(s(10))));
    
            %   Calculate without additional quantities
            utmp(r+10)=sqrt( beta(10)*real(xi0)*(1-sqrt(s(10)))^2/(1-sum(s)) );%In formula we can chose th sign + or - in (1 \mp sqrt(s(10))
            %Calculate others u_N
                if r<0
                    Nmin=-9;
                    Nmax=r+10;
                else
                    Nmin=r-9;
                    Nmax=10;
                end
            for N=Nmin:Nmax
                if(N-r==r)
                else
                    %u(r-N+10)=sqrt( s(N+10)*beta(N+10)*(real(xi_0)+X)/(1-s(10)) );
                    utmp(N-r+10)=sqrt( s(N+10)*beta(N+10)*real(xi0)/(1-sum(s)) );
                end
            end
    
    %   Calculate other elements of array using u(-N)=u(N)
            for N=1:9
                if(utmp(N)==0)
                    utmp(N)=utmp(20-N);
                else
                    utmp(20-N)=utmp(N);
                end
            end
            


        end
    end
    
end

