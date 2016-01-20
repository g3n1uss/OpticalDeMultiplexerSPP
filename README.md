# OpticalImpedanceDeMultiplexerSPP

## How to run the code?
To try the code run "run_me.m".

## What are the default settings?

Default settings include a gold film, the resonace in 1st order, 
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
  - diffracted spctra in which resonance is wanted "r"
  - wavelength of the fallen beam "lambda_res"
  - angle at which the beam falls "theta_res"
  
3. desired distribution of outgoing spectra "fluxes"
