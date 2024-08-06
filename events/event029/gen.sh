lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 29.598358358358357 --fixed-mass2 45.314594594594595 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026530355.2066963 \
--gps-end-time 1026537555.2066963 \
--d-distr volume \
--min-distance 1461.326411592411e3 --max-distance 1461.346411592411e3 \
--l-distr fixed --longitude 34.1306266784668 --latitude -6.510412693023682 --i-distr uniform \
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
