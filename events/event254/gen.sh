lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.882122122122123 --fixed-mass2 82.20992992992993 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025788353.398794 \
--gps-end-time 1025795553.398794 \
--d-distr volume \
--min-distance 1074.4435333391373e3 --max-distance 1074.4635333391373e3 \
--l-distr fixed --longitude -115.60763549804688 --latitude -1.4018831253051758 --i-distr uniform \
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
