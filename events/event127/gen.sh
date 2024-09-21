lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 14.134254254254255 --fixed-mass2 65.65325325325325 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1004733273.9740808 \
--gps-end-time 1004740473.9740808 \
--d-distr volume \
--min-distance 1339.3605200385512e3 --max-distance 1339.3805200385511e3 \
--l-distr fixed --longitude 116.67118072509766 --latitude 15.91771411895752 --i-distr uniform \
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
