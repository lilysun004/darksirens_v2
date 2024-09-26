lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 42.541141141141146 --fixed-mass2 47.66782782782783 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1004922977.8084126 \
--gps-end-time 1004930177.8084126 \
--d-distr volume \
--min-distance 3546.6583279847446e3 --max-distance 3546.678327984745e3 \
--l-distr fixed --longitude -24.3148193359375 --latitude -7.923545837402344 --i-distr uniform \
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
