lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 25.564244244244243 --fixed-mass2 40.77621621621622 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029390806.1249086 \
--gps-end-time 1029398006.1249086 \
--d-distr volume \
--min-distance 1216.9643358176136e3 --max-distance 1216.9843358176136e3 \
--l-distr fixed --longitude -129.0986328125 --latitude -54.16886520385742 --i-distr uniform \
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
