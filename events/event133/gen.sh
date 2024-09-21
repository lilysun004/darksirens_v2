lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 37.162322322322325 --fixed-mass2 69.26714714714716 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000818658.2215441 \
--gps-end-time 1000825858.2215441 \
--d-distr volume \
--min-distance 2629.888092975726e3 --max-distance 2629.9080929757265e3 \
--l-distr fixed --longitude 79.43458557128906 --latitude -8.392428398132324 --i-distr uniform \
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
