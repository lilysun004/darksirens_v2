lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.966166166166165 --fixed-mass2 70.52780780780782 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1012387542.7497379 \
--gps-end-time 1012394742.7497379 \
--d-distr volume \
--min-distance 1777.1162618189085e3 --max-distance 1777.1362618189085e3 \
--l-distr fixed --longitude -32.23699951171875 --latitude -58.492244720458984 --i-distr uniform \
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
