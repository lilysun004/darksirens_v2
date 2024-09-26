lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 38.75915915915916 --fixed-mass2 67.67031031031031 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025536284.4282513 \
--gps-end-time 1025543484.4282513 \
--d-distr volume \
--min-distance 1589.0450873280797e3 --max-distance 1589.0650873280797e3 \
--l-distr fixed --longitude 114.57084655761719 --latitude -34.04129409790039 --i-distr uniform \
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
