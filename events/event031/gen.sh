lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 17.411971971971973 --fixed-mass2 59.433993993993994 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027195680.8604957 \
--gps-end-time 1027202880.8604957 \
--d-distr volume \
--min-distance 2151.730914193182e3 --max-distance 2151.7509141931823e3 \
--l-distr fixed --longitude 111.0147476196289 --latitude 10.736037254333496 --i-distr uniform \
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
