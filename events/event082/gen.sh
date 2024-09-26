lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 66.4936936936937 --fixed-mass2 73.30126126126126 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006217468.749513 \
--gps-end-time 1006224668.749513 \
--d-distr volume \
--min-distance 3987.0921988880373e3 --max-distance 3987.1121988880377e3 \
--l-distr fixed --longitude 25.443248748779297 --latitude 48.546627044677734 --i-distr uniform \
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
