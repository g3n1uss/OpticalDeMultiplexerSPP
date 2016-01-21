# OpticalImpedanceDeMultiplexerSPP

## What all these "demultiplexor", "SPP", "Impedance", etc. mean?

The answers on these and other questions can be found at the corresponding [wiki page](https://github.com/g3n1uss/OpticalImpedanceDeMultiplexerSPP/wiki).

## What should I do to run the code?

Simply execute "run_me.m" in Matlab. As output one gets the impedance grating 
that equally distributes the energy of a single beam from the helium-neon 
laser into two outgoing beams. Along with the impedance grating, which is 
characterized by `u_r` and `psi_n`, you get a bunch of plots representing the 
resonance harmonics `|h_r|^2`, outgoing normalized energy fluxes `s_i` and the 
absoption rate `A`. A typical set of plots looks like this
![tag](https://github.com/g3n1uss/OpticalImpedanceDeMultiplexerSPP/blob/master/pictures/Example4r1.png "A typical output of the program")

## What are the default parameters?

The default parameters are
- a gold film
- the resonace is in 1st order
- the incident beam is from a helium-neon laser
- the inclination angle is 10 degrees, which is chosen randomly.

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
5. Add titles to the graphs
6. Expand this readme file
