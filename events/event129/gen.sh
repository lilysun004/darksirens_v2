lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 19.765205205205206 --fixed-mass2 54.89561561561562 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009480252.9972887 \
--gps-end-time 1009487452.9972887 \
--d-distr volume \
--min-distance 964.2216615630647e3 --max-distance 964.2416615630647e3 \
--l-distr fixed --longitude -38.65533447265625 --latitude -74.01527404785156 --i-distr uniform \
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
