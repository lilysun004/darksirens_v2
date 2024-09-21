lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.98570570570571 --fixed-mass2 67.16604604604605 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029683564.4893504 \
--gps-end-time 1029690764.4893504 \
--d-distr volume \
--min-distance 1988.583455069821e3 --max-distance 1988.603455069821e3 \
--l-distr fixed --longitude -127.38031005859375 --latitude -56.35983657836914 --i-distr uniform \
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
