lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 20.437557557557557 --fixed-mass2 84.8152952952953 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021961746.319757 \
--gps-end-time 1021968946.319757 \
--d-distr volume \
--min-distance 3441.4878821966618e3 --max-distance 3441.507882196662e3 \
--l-distr fixed --longitude 18.933446884155273 --latitude -25.99126434326172 --i-distr uniform \
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
