lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 48.25613613613614 --fixed-mass2 79.1003003003003 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024438264.3102298 \
--gps-end-time 1024445464.3102298 \
--d-distr volume \
--min-distance 1500.011892347879e3 --max-distance 1500.031892347879e3 \
--l-distr fixed --longitude 150.42283630371094 --latitude 11.046295166015625 --i-distr uniform \
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
