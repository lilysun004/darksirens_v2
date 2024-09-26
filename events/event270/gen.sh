lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 21.950350350350348 --fixed-mass2 71.95655655655656 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014329717.6954294 \
--gps-end-time 1014336917.6954294 \
--d-distr volume \
--min-distance 2673.219168972814e3 --max-distance 2673.2391689728142e3 \
--l-distr fixed --longitude 29.76407814025879 --latitude 25.332151412963867 --i-distr uniform \
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
