lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 20.941821821821822 --fixed-mass2 46.99547547547548 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026652252.3297422 \
--gps-end-time 1026659452.3297422 \
--d-distr volume \
--min-distance 1648.2351980302349e3 --max-distance 1648.2551980302349e3 \
--l-distr fixed --longitude 107.53668975830078 --latitude -39.338138580322266 --i-distr uniform \
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
