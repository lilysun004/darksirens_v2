lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.64952952952953 --fixed-mass2 42.541141141141146 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1004410859.7499921 \
--gps-end-time 1004418059.7499921 \
--d-distr volume \
--min-distance 2840.907415859213e3 --max-distance 2840.9274158592134e3 \
--l-distr fixed --longitude 17.97146987915039 --latitude -5.69106912612915 --i-distr uniform \
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
