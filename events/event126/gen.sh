lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 8.671391391391392 --fixed-mass2 75.99067067067067 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001204086.4835423 \
--gps-end-time 1001211286.4835423 \
--d-distr volume \
--min-distance 643.482489733544e3 --max-distance 643.5024897335439e3 \
--l-distr fixed --longitude 45.39585494995117 --latitude 25.17854118347168 --i-distr uniform \
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
