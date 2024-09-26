lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 25.64828828828829 --fixed-mass2 81.3694894894895 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023208402.1436135 \
--gps-end-time 1023215602.1436135 \
--d-distr volume \
--min-distance 1172.7733590924186e3 --max-distance 1172.7933590924185e3 \
--l-distr fixed --longitude -136.74444580078125 --latitude 55.64585494995117 --i-distr uniform \
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
