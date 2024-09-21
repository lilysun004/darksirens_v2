lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 22.11843843843844 --fixed-mass2 32.96012012012012 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023069773.7577202 \
--gps-end-time 1023076973.7577202 \
--d-distr volume \
--min-distance 1649.6372652458995e3 --max-distance 1649.6572652458995e3 \
--l-distr fixed --longitude -56.429168701171875 --latitude -69.36677551269531 --i-distr uniform \
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
