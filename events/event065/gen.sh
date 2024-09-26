lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 34.80908908908909 --fixed-mass2 42.289009009009014 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023703216.9326062 \
--gps-end-time 1023710416.9326062 \
--d-distr volume \
--min-distance 1431.362576595785e3 --max-distance 1431.382576595785e3 \
--l-distr fixed --longitude 157.09188842773438 --latitude -38.65841293334961 --i-distr uniform \
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
