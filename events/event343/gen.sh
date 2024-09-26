lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 49.01253253253254 --fixed-mass2 78.25985985985986 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005655834.5621067 \
--gps-end-time 1005663034.5621067 \
--d-distr volume \
--min-distance 2578.934267152472e3 --max-distance 2578.9542671524723e3 \
--l-distr fixed --longitude 80.99854278564453 --latitude 39.316444396972656 --i-distr uniform \
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
