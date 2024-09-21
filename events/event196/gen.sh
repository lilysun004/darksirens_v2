lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 38.84320320320321 --fixed-mass2 25.64828828828829 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022053105.5799644 \
--gps-end-time 1022060305.5799644 \
--d-distr volume \
--min-distance 1024.5205046306928e3 --max-distance 1024.5405046306928e3 \
--l-distr fixed --longitude -51.451446533203125 --latitude 71.13233184814453 --i-distr uniform \
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
