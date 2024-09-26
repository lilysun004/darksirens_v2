lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 43.04540540540541 --fixed-mass2 75.40236236236237 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1004205880.7445923 \
--gps-end-time 1004213080.7445923 \
--d-distr volume \
--min-distance 1242.4164226441555e3 --max-distance 1242.4364226441555e3 \
--l-distr fixed --longitude -144.67576599121094 --latitude -11.850395202636719 --i-distr uniform \
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
