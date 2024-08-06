lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 34.13673673673674 --fixed-mass2 59.433993993993994 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001055368.8159581 \
--gps-end-time 1001062568.8159581 \
--d-distr volume \
--min-distance 3363.084352558549e3 --max-distance 3363.1043525585496e3 \
--l-distr fixed --longitude 50.51388168334961 --latitude 59.98554992675781 --i-distr uniform \
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
