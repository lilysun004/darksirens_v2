lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 25.73233233233233 --fixed-mass2 57.16480480480481 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1028372741.7933506 \
--gps-end-time 1028379941.7933506 \
--d-distr volume \
--min-distance 2118.738979632091e3 --max-distance 2118.7589796320913e3 \
--l-distr fixed --longitude 115.34805297851562 --latitude 32.965267181396484 --i-distr uniform \
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
