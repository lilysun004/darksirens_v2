lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.882122122122123 --fixed-mass2 62.37553553553554 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018135227.8544396 \
--gps-end-time 1018142427.8544396 \
--d-distr volume \
--min-distance 1480.6925302456589e3 --max-distance 1480.7125302456589e3 \
--l-distr fixed --longitude -72.17129516601562 --latitude -81.67418670654297 --i-distr uniform \
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
