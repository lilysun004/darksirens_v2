lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 43.63371371371372 --fixed-mass2 48.17209209209209 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006949171.2815545 \
--gps-end-time 1006956371.2815545 \
--d-distr volume \
--min-distance 3369.4673872506273e3 --max-distance 3369.4873872506278e3 \
--l-distr fixed --longitude -38.80413818359375 --latitude -84.67707824707031 --i-distr uniform \
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
