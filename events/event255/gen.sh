lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 31.53137137137137 --fixed-mass2 73.80552552552552 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020238264.2124377 \
--gps-end-time 1020245464.2124377 \
--d-distr volume \
--min-distance 2672.0317803381467e3 --max-distance 2672.051780338147e3 \
--l-distr fixed --longitude 155.241943359375 --latitude -12.206199645996094 --i-distr uniform \
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
