lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 41.112392392392394 --fixed-mass2 49.5167967967968 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1017907609.5373992 \
--gps-end-time 1017914809.5373992 \
--d-distr volume \
--min-distance 2942.043492043861e3 --max-distance 2942.0634920438615e3 \
--l-distr fixed --longitude 104.82008361816406 --latitude -49.00192642211914 --i-distr uniform \
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
