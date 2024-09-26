lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 23.967407407407407 --fixed-mass2 20.77373373373373 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027032513.1880405 \
--gps-end-time 1027039713.1880405 \
--d-distr volume \
--min-distance 1872.3665884117715e3 --max-distance 1872.3865884117715e3 \
--l-distr fixed --longitude 117.52745819091797 --latitude -56.042728424072266 --i-distr uniform \
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
