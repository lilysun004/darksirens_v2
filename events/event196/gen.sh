lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 28.673873873873873 --fixed-mass2 49.5167967967968 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1013188472.341692 \
--gps-end-time 1013195672.341692 \
--d-distr volume \
--min-distance 1520.4670752799452e3 --max-distance 1520.4870752799452e3 \
--l-distr fixed --longitude 33.84357452392578 --latitude 38.01304626464844 --i-distr uniform \
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
