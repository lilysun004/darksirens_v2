lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 34.13673673673674 --fixed-mass2 61.19891891891892 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016654150.3873323 \
--gps-end-time 1016661350.3873323 \
--d-distr volume \
--min-distance 2653.697757834175e3 --max-distance 2653.7177578341752e3 \
--l-distr fixed --longitude 112.07353973388672 --latitude -42.68403625488281 --i-distr uniform \
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
