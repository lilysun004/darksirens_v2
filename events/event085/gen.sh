lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 40.355995995996 --fixed-mass2 76.4108908908909 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1011272857.9852257 \
--gps-end-time 1011280057.9852257 \
--d-distr volume \
--min-distance 2406.0438321407205e3 --max-distance 2406.063832140721e3 \
--l-distr fixed --longitude 85.51760864257812 --latitude -27.607995986938477 --i-distr uniform \
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
