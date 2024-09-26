lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 7.242642642642643 --fixed-mass2 12.957637637637639 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024386596.6565373 \
--gps-end-time 1024393796.6565373 \
--d-distr volume \
--min-distance 343.326589669545e3 --max-distance 343.346589669545e3 \
--l-distr fixed --longitude -113.27169799804688 --latitude -49.12761306762695 --i-distr uniform \
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
