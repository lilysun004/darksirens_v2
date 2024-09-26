lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.90166166166166 --fixed-mass2 70.19163163163164 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1028339560.0414574 \
--gps-end-time 1028346760.0414574 \
--d-distr volume \
--min-distance 1673.5324051783261e3 --max-distance 1673.5524051783261e3 \
--l-distr fixed --longitude -108.47933959960938 --latitude 57.01600646972656 --i-distr uniform \
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
