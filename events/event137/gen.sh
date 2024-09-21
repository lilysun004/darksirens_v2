lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 18.504544544544544 --fixed-mass2 59.686126126126126 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027955608.7978591 \
--gps-end-time 1027962808.7978591 \
--d-distr volume \
--min-distance 3153.1676362821995e3 --max-distance 3153.1876362822e3 \
--l-distr fixed --longitude 89.53547668457031 --latitude 64.00318145751953 --i-distr uniform \
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
