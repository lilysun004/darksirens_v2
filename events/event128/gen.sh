lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 43.29753753753754 --fixed-mass2 78.59603603603604 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009103229.5083692 \
--gps-end-time 1009110429.5083692 \
--d-distr volume \
--min-distance 1267.833297336709e3 --max-distance 1267.853297336709e3 \
--l-distr fixed --longitude -63.686431884765625 --latitude -26.434377670288086 --i-distr uniform \
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
