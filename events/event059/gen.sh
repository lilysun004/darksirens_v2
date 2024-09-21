lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 11.360800800800803 --fixed-mass2 17.411971971971973 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1030843378.9729395 \
--gps-end-time 1030850578.9729395 \
--d-distr volume \
--min-distance 403.08719508225573e3 --max-distance 403.1071950822557e3 \
--l-distr fixed --longitude -105.35647583007812 --latitude 44.333702087402344 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
