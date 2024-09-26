lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 31.027107107107106 --fixed-mass2 38.67511511511512 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023264046.6933607 \
--gps-end-time 1023271246.6933607 \
--d-distr volume \
--min-distance 1520.806553400107e3 --max-distance 1520.826553400107e3 \
--l-distr fixed --longitude -142.35934448242188 --latitude -62.4290771484375 --i-distr uniform \
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
