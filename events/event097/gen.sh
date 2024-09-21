lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.48748748748749 --fixed-mass2 44.306066066066066 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006820049.7967336 \
--gps-end-time 1006827249.7967336 \
--d-distr volume \
--min-distance 1280.5656836378682e3 --max-distance 1280.5856836378682e3 \
--l-distr fixed --longitude -56.82464599609375 --latitude 22.28388023376465 --i-distr uniform \
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
