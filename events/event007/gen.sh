lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 70.10758758758759 --fixed-mass2 31.027107107107106 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026969853.4019648 \
--gps-end-time 1026977053.4019648 \
--d-distr volume \
--min-distance 2139.9090958377833e3 --max-distance 2139.9290958377837e3 \
--l-distr fixed --longitude -31.297760009765625 --latitude -12.945714950561523 --i-distr uniform \
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
