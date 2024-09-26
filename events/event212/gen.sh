lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 43.12944944944945 --fixed-mass2 34.30482482482483 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1017048204.4113002 \
--gps-end-time 1017055404.4113002 \
--d-distr volume \
--min-distance 1096.893005133769e3 --max-distance 1096.913005133769e3 \
--l-distr fixed --longitude 153.92462158203125 --latitude 20.23395538330078 --i-distr uniform \
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
