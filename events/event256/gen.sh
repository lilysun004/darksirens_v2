lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 30.52284284284284 --fixed-mass2 31.027107107107106 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014588853.4385543 \
--gps-end-time 1014596053.4385543 \
--d-distr volume \
--min-distance 1441.0222014477963e3 --max-distance 1441.0422014477963e3 \
--l-distr fixed --longitude 113.39300537109375 --latitude -1.7607717514038086 --i-distr uniform \
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
