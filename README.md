# OpticalImpedanceDeMultiplexerSPP

## What is "demultiplexor", "SPP", "Impedance"?

Answers on these and other questions can be found on the corresponding [wiki page](https://github.com/g3n1uss/OpticalImpedanceDeMultiplexerSPP/wiki).

## What should I do to run the code?

Simply execute "run_me.m" in Matlab and you will get the impedance grating 
that equally distributes the energy of a single beam from the helium-neon 
laser into two outgoing spectra. Along with the impedance grating you get 
graphs representing the resonance harmonics `h_r`, outgoing normalized 
fluxes and the absoption rate. A typical set of plots looks like this
[!Alt text](https://github.com/g3n1uss/OpticalImpedanceDeMultiplexerSPP/blob/master/pictures/Example2r1.png, "A typical output of the program")

## What are the default parameters?

Default parameters include a gold film, the resonace in 1st order, 
the fallen beam from a helium-neon laser and the inclination angle 
10 degrees, which is chosen randomly.

## Where can I find other examples?

Other examples are in the end of file "run_me.m".

## What is the input data?

Input data must contain:

1. characteristics of the material including
  - plasma frequency "omega_p"
  - absoption coefficient "eta"
  
2. specifics of the resonance one would like to consider
  - diffracted spectra in which resonance is wanted "r"
  - wavelength of the fallen beam "lambda_res"
  - angle at which the beam falls "theta_res"
  
3. desired distribution of outgoing spectra "fluxes"

# TODO
1. Get rid of limitation of 20 outgoing spectra
2. Add 3D data plot
3. Add double resonance
4. Finish wiki page
