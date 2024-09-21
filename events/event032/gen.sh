lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 9.848008008008009 --fixed-mass2 57.585025025025026 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002394263.7960551 \
--gps-end-time 1002401463.7960551 \
--d-distr volume \
--min-distance 980.1824207963854e3 --max-distance 980.2024207963854e3 \
--l-distr fixed --longitude 125.43824005126953 --latitude -1.789669394493103 --i-distr uniform \
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
