lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 8.923523523523524 --fixed-mass2 55.652012012012015 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026736167.5212374 \
--gps-end-time 1026743367.5212374 \
--d-distr volume \
--min-distance 1011.7752380751241e3 --max-distance 1011.7952380751241e3 \
--l-distr fixed --longitude -39.80865478515625 --latitude 55.91836166381836 --i-distr uniform \
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
