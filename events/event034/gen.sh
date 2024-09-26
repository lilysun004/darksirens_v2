lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 7.410730730730731 --fixed-mass2 75.40236236236237 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009925587.6869302 \
--gps-end-time 1009932787.6869302 \
--d-distr volume \
--min-distance 449.10703163469964e3 --max-distance 449.1270316346996e3 \
--l-distr fixed --longitude 10.504304885864258 --latitude 1.756813883781433 --i-distr uniform \
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
