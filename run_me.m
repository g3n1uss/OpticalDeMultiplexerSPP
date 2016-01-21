% This is the configuration script than after entering all the necessary 
%configuration data runs the main function "MainFunction"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The input data MUST include
% "plasma_freq" - plasma frequency of a particular metal
% "absorp_coef" - absorption coefficient of a particular metal
% "order_res" - the number of a diffracted spectra at which we want to
% observe the resonance
% "angle_res" - incident angle
% "energy_fluxes" - the desired energy distributions among outgoing spectra
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter properties of the film, characteristics of the material
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Let's say we consider a gold film, this data can found in special tables
plasma_freq=13.8*10^15;% plasma frequency of gold
absorp_coef=10^14;% absorption coefficient of gold


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter the resonance properties. Could be arbitrary
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% we want a resonance in order_res-th order
order_res=1;
% at this wavelength (the helium-neon laser)
wavelength_res=632;
% and at this angle
angle_res=10;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter the desired energy distribution among energy fluxes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
energy_fluxes=zeros(1,20);
energy_fluxes(10)=0.25;energy_fluxes(9)=0.25;

% The main function find the grating and plots some graphs
grating=MainFunction(plasma_freq,absorp_coef,wavelength_res,angle_res,order_res,energy_fluxes);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Other examples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% s=zeros(1,20);s(10)=0.25;s(9)=0.25;
% order_res=1;angle_res=10;wavelength_res=632;
% 
% s=zeros(1,20);s(10)=0;s(9)=0.35;
% order_res=-2;angle_res=30;wavelength_res=632;
% 
% s=zeros(1,20);s(8)=0.1;s(9)=0.2;s(10)=0.3;
% order_res=-3;angle_res=35;wavelength_res=632;




