lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 12.53741741741742 --fixed-mass2 34.30482482482483 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014989763.3877759 \
--gps-end-time 1014996963.3877759 \
--d-distr volume \
--min-distance 962.7811662431834e3 --max-distance 962.8011662431834e3 \
--l-distr fixed --longitude 7.426095485687256 --latitude 19.269948959350586 --i-distr uniform \
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
