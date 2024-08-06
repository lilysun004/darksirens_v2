lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 38.59107107107108 --fixed-mass2 37.58254254254255 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029264033.0657158 \
--gps-end-time 1029271233.0657158 \
--d-distr volume \
--min-distance 1234.3400451960258e3 --max-distance 1234.3600451960258e3 \
--l-distr fixed --longitude -24.2763671875 --latitude 64.30168151855469 --i-distr uniform \
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
