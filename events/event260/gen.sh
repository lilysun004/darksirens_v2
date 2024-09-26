lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 42.96136136136136 --fixed-mass2 55.652012012012015 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1028335443.1705617 \
--gps-end-time 1028342643.1705617 \
--d-distr volume \
--min-distance 1205.2099957891708e3 --max-distance 1205.2299957891707e3 \
--l-distr fixed --longitude 42.98512268066406 --latitude 22.28227996826172 --i-distr uniform \
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
