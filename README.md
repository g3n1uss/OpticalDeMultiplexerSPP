#### This project models a photonic demultiplexor utilizing the surface plasmon-polariton resonance on impedance gratings.

## What is this project about? What are all these "demultiplexor", "SPP", "Impedance", etc.? 

The answers to these and other questions can be found on [this wiki page](../../wiki).


## What should I do to run the code? What do I get as output?

Simply execute `run_me.m` in MatLab. As output you get the impedance grating equally distributing the energy of the helium-neon laser beam into two outgoing beams. Along with the impedance grating, which is characterized by the amplitudes `u_n` and the phases `psi_n`, the code generates a bunch of plots representing the resonance harmonics `|h_r|^2`, outgoing normalized energy fluxes `s_i` and the absoption rate `A`. A typical set of plots looks like this ![tag](/pictures/Example4r1.png "A typical output.")

## What should I enter as input?

Input parameters (located in the script `run_me.m`) must contain:

1. characteristics of the material (can be found in the specific tables, e.g. optical properties of metals) including
  - plasma frequency `plasma_freq`
  - absorption coefficient `absopr_coef`
  
2. properties of the resonance
  - resonance happens in the `order_res` order
  - wavelength of the falling beam `wavelength_res` (for example, the laser's wavelength)
  - inclination angle `angle_res`
  
3. desired distribution of outgoing spectrum "energy_fluxes"

## What is the default input?

The default configuration is:
- gold film
- resonance in the 1st order
- incident beam is from a helium-neon laser
- inclination angle is 10 degrees (chosen randomly).

## Where can I find other examples?

Other examples are in the end of file `run_me.m`.

## What programming paradigm this code is written in?

This project is a mixture of OOP and procedural paradigms, plus a configuration script.

# TODO
1. Add a picture of the geometry to the output (picture of a resonance), instead of one long picture of the grating create two - one is a grating and a second one - picture of geometry
2. Get rid of limitation of 20 outgoing spectra
2. Add 3D data plot
3. Add double resonance
