lalapps_inspinj \
`# Write output to inj.xml.` \
-o inj.xml \
`# Mass distribution.` \
--m-distr fixMasses --fixed-mass1 30 --fixed-mass2 30 \
`# Coalescence time distribution: adjust time step, start, and stop` \
`# time to control the number of injections.` \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000000000 \
--gps-end-time 1000072000 \
`# Distance distribution: uniform in Euclidean volume.` \
`# WARNING: distances are in kpc.` \
--d-distr volume \
--min-distance 270e3 --max-distance 280e3 \
`# Sky position and inclination distribution: isotropic.` \
--l-distr fixed --longitude -87.594213 --latitude -42.417559 --i-distr uniform \
`# Write a table of CBC injections to inj.xml.` \
--f-lower 30 --disable-spin \
--waveform IMRPhenomXAS

bayestar-sample-model-psd \
`# Write output to psd.xml.` \
-o psd.xml \
`# Specify noise models for desired detectors.` \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--I1=aLIGOZeroDetHighPower \
--V1=AdvVirgo \
--K1=KAGRA

bayestar-realize-coincs \
`# Write output to coinc.xml.` \
-o coinc.xml \
`# Use the injections and noise PSDs that we generated.` \
inj.xml --reference-psd psd.xml \
`# Specify which detectors are in science mode.` \
--detector H1 L1 V1 I1 K1 \
`# Optionally, add Gaussian noise (rather than zero noise).` \
--measurement-error gaussian-noise \
`# Optionally, adjust the detection threshold: single-detector` \
`# SNR, network SNR, and minimum number of detectors above` \
`# threshold to form a coincidence.` \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
`# Optionally, save triggers that were below the single-detector` \
`# threshold.` \
--keep-subthreshold

bayestar-localize-coincs coinc.xml