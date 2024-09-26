lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 20.857777777777777 --fixed-mass2 29.01005005005005 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005628614.7744825 \
--gps-end-time 1005635814.7744825 \
--d-distr volume \
--min-distance 636.877952446387e3 --max-distance 636.897952446387e3 \
--l-distr fixed --longitude 171.99307250976562 --latitude -42.554176330566406 --i-distr uniform \
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
