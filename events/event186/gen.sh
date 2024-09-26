lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 28.589829829829828 --fixed-mass2 79.8566966966967 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1003946531.3594061 \
--gps-end-time 1003953731.3594061 \
--d-distr volume \
--min-distance 1638.63870747926e3 --max-distance 1638.6587074792599e3 \
--l-distr fixed --longitude 6.80543851852417 --latitude 14.346654891967773 --i-distr uniform \
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
