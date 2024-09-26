lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.461901901901903 --fixed-mass2 79.60456456456457 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021250487.6704358 \
--gps-end-time 1021257687.6704358 \
--d-distr volume \
--min-distance 1639.696412348706e3 --max-distance 1639.716412348706e3 \
--l-distr fixed --longitude 37.05699157714844 --latitude 42.668846130371094 --i-distr uniform \
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
