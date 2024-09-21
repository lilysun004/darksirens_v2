lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 30.018578578578577 --fixed-mass2 31.363283283283284 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000145191.6785393 \
--gps-end-time 1000152391.6785393 \
--d-distr volume \
--min-distance 736.8292132607039e3 --max-distance 736.8492132607039e3 \
--l-distr fixed --longitude 66.19383239746094 --latitude -64.99418640136719 --i-distr uniform \
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
