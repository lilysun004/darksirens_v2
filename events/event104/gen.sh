lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.3973973973974 --fixed-mass2 33.044164164164165 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021221487.2444137 \
--gps-end-time 1021228687.2444137 \
--d-distr volume \
--min-distance 2046.7796684769896e3 --max-distance 2046.7996684769896e3 \
--l-distr fixed --longitude 0.07798957824707031 --latitude 59.1573486328125 --i-distr uniform \
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
