lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 57.83715715715716 --fixed-mass2 73.38530530530531 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021317694.2411252 \
--gps-end-time 1021324894.2411252 \
--d-distr volume \
--min-distance 769.8555918588017e3 --max-distance 769.8755918588017e3 \
--l-distr fixed --longitude 47.68849563598633 --latitude -32.617958068847656 --i-distr uniform \
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
