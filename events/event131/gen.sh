lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 32.11967967967968 --fixed-mass2 79.1003003003003 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1011502629.9673622 \
--gps-end-time 1011509829.9673622 \
--d-distr volume \
--min-distance 3243.7602724229587e3 --max-distance 3243.780272422959e3 \
--l-distr fixed --longitude 99.11687469482422 --latitude 15.472060203552246 --i-distr uniform \
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
