lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 28.085565565565567 --fixed-mass2 74.8980980980981 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027761772.2026111 \
--gps-end-time 1027768972.2026111 \
--d-distr volume \
--min-distance 2816.588800571768e3 --max-distance 2816.6088005717684e3 \
--l-distr fixed --longitude -84.11932373046875 --latitude -23.704866409301758 --i-distr uniform \
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
