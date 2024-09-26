lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 22.622702702702703 --fixed-mass2 83.38654654654655 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006270549.7295109 \
--gps-end-time 1006277749.7295109 \
--d-distr volume \
--min-distance 1863.6155632964121e3 --max-distance 1863.635563296412e3 \
--l-distr fixed --longitude 124.02342224121094 --latitude -13.059956550598145 --i-distr uniform \
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
