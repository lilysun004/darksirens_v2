lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.461901901901903 --fixed-mass2 32.035635635635636 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1013007532.3027648 \
--gps-end-time 1013014732.3027648 \
--d-distr volume \
--min-distance 1121.108354207739e3 --max-distance 1121.128354207739e3 \
--l-distr fixed --longitude 39.700260162353516 --latitude 31.79444694519043 --i-distr uniform \
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
