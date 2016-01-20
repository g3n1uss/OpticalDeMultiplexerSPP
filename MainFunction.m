function [xifinal]=MainFunction(omega_p,eta,lambda_res,theta_res,r,fluxes)
%MAINFUNCTION This function computes properties of the grating realizing
%the desired energy distribution and plots some data
%   Detailed explanation goes here


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate properties of the film such as
% Dielectric function epsilon, Unmodulated value of the impedance xi0, etc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% create object Surface material containing all the characteristics of the
% material at the resonant point
goldsurface=SurfaceMaterial(lambda_res,omega_p,eta);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the period of the impedance grating
% sin(th_res)+r lambda_res/d_res=sqrt(1+Im(xi)^2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
period=r*lambda_res/(sqrt(1+imag(goldsurface.xi0)^2)-sin(theta_res*pi/180));
% The following spectra will be outgoing (Nn,...,Nm)
Np=floor((1-sin(theta_res*pi/180))*period/lambda_res);
Nm=-floor((1+sin(theta_res*pi/180))*period/lambda_res);
% the number of outgoing spectra is
out_num=Np-Nm+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If the desired energy distribution is not given calculate for equally
% distributed energy in all outging spectra
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<6
    s=zeros(1,20);
    % IT SEEMS LIKE THE UPPER BOUND ON TOTAL ENERGY IS NOT KNOWN, LET
    % SAY IT EQUALS TO 0.5, THE REST IS ABSORPTED BY SPP
    % the energy in every outgoing spectra is
    en=0.5/out_num;
    for i=Nm+10:Np+10
        s(i)=en;
    end
else
    s=fluxes;
end
    

% find tangential wavevectors "beta" for diffracted spectra
diffSpectra=DiffAngles(theta_res,lambda_res,period);
betas=diffSpectra.beta;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find properties of the grating from the analytical solution of the
% inverse diffraction problem. This would be the initial grating
% configuration. Later on we will correct it by minimizing the appropriate 
% functional.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% At first we have only the amplitudes of various modes of the grating
out_num_tmp=20;
uinit=AnalyticSolution(out_num_tmp,goldsurface.xi0,s,betas,r).u;
psiinit=zeros(1,20);
xianal=zeros(1,20);
xianal(:)=1i*uinit(:).*exp(1i*psiinit(:));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define the correcting functional and then minimize it
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
func=Functional(goldsurface.xi0,betas,uinit,r,s);
% minimize it
funcmin=func.Minimize(); 
% construct the resulting grating
xifinal=zeros(1,20);
xifinal(:)=1i*funcmin.ufinal(:).*exp(1i*funcmin.psifinal(:));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate data to plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% At first generate data for the initial grating obtained from the 
% analytic solution
dataGenInit=DataGenerator(r,lambda_res,theta_res,goldsurface,diffSpectra,xianal);
% data for initial grating
% along wavelength
[s_nonres_w,abs_h_res2_w,absorption_w,wavelength_w,~]=dataGenInit.getDataWavelength(0);
% along angle
[s_nonres_a,abs_h_res2_a,absorption_a,~,thetas_a]=dataGenInit.getDataAngle(0);

% data for final grating
dataGenFinal=DataGenerator(r,lambda_res,theta_res,goldsurface,diffSpectra,xifinal);
% along wavelength
[s_nonres_w_f,abs_h_res2_w_f,absorption_w_f,wavelength_w_f,~]=dataGenFinal.getDataWavelength(0);
% along angle
[s_nonres_a_f,abs_h_res2_a_f,absorption_a_f,~,thetas_a_f]=dataGenFinal.getDataAngle(0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Actually data plotting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot the grating
t=0:.01:1;
% initial grating
grat_i=BuildGrating(uinit,psiinit,goldsurface.xi0,t);
% label for initial grating
labelUinit=GenerateLabel('u^i',uinit);
labelXi=strcat(labelUinit,', \xi_0^{"}=',num2str(imag(goldsurface.xi0)));
% final grating
grat_f=BuildGrating(funcmin.ufinal,funcmin.psifinal,goldsurface.xi0,t);
% label for final grating
labelUfinal=GenerateLabel('u^f',funcmin.ufinal);
labelPsifinal=GenerateLabel('psi^f',funcmin.psifinal*180/pi);
labelXi_f=strcat(labelUfinal, labelPsifinal,', \xi_0^{"}=',...
    num2str(imag(goldsurface.xi0)));
% set the display window to fullscreen
figure('units','normalized','outerposition',[0 0 1 1]);
% draw grating
subplot(3,2,[1,2]),plot(t,grat_i,'--k',t,grat_f,'k'),text(0.3,...
    imag(goldsurface.xi0)/2,labelXi),...
    text(0.3,imag(goldsurface.xi0)/1.5,labelXi_f),xlabel('x/d'),...
    ylabel('\xi^{"}'),legend('Grating from analytical solution','Corrected grating')


% plot the resonance amplitude from then analytical solution
subplot(3,2,3), plot(wavelength_w(:),abs_h_res2_w(:),'--k',wavelength_w_f(:),...
    abs_h_res2_w_f(:),'k'),grid on, xlabel('\lambda, nm'),ylabel('|h_r|^2'),...
    legend('Analytical solution','Corrected solution')


% plot the fluxes obtained from the analitycal solution
% label for the fluxes
labelS=GenerateLabel('s',s);
% label for legend
legendlabel=cell(1,2*(out_num+1));
ind=1;
legendlabel{ind}='A^i';
for i=Nm:Np
    ind=ind+1;
    legendlabel{ind}=strcat('s^i_{',num2str(i),'}');
end
ind=ind+1;
legendlabel{ind}='A^f';
for i=Nm:Np
    ind=ind+1;
    legendlabel{ind}=strcat('s^f_{',num2str(i),'}');
end
% plot
subplot(3,2,4),
plot(wavelength_w(:),absorption_w(:),'--');
hold on
plot(wavelength_w_f(:),absorption_w_f(:),'-');
for i=Nm+10:Np+10
    plot(wavelength_w(:),s_nonres_w(:,i),'--');
    plot(wavelength_w_f(:),s_nonres_w_f(:,i),'-');
end
grid on, text(wavelength_w(10),0.8,labelS),xlabel('\lambda, nm'), legend(legendlabel{:})
hold off

% plot the corrected resonance harmonic
subplot(3,2,5), plot(thetas_a(:),abs_h_res2_a(:),'--k',thetas_a_f(:),...
    abs_h_res2_a_f(:),'k'),grid on, xlabel('\theta, degrees'),ylabel('|h_r|^2'),...
    legend('Analytical solution','Corrected solution')

% plot the corrected fluxes
subplot(3,2,6),
plot(thetas_a(:),absorption_a(:),'--');
hold on
plot(thetas_a_f(:),absorption_a_f(:),'-');
for i=Nm+10:Np+10
    plot(thetas_a(:),s_nonres_a(:,i),'--');
    plot(thetas_a_f(:),s_nonres_a_f(:,i),'-');
end
grid on, text(thetas_a(10),0.8,labelS),xlabel('\lambda, nm'), legend(legendlabel{:})
hold off
