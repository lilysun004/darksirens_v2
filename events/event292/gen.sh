lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 42.373053053053056 --fixed-mass2 59.34994994994995 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020548221.611394 \
--gps-end-time 1020555421.611394 \
--d-distr volume \
--min-distance 1642.33867874168e3 --max-distance 1642.35867874168e3 \
--l-distr fixed --longitude 81.05838012695312 --latitude 7.271229267120361 --i-distr uniform \
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
