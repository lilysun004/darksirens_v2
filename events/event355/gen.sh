lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 9.007567567567568 --fixed-mass2 58.593553553553555 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025471738.4542366 \
--gps-end-time 1025478938.4542366 \
--d-distr volume \
--min-distance 1211.258152205781e3 --max-distance 1211.278152205781e3 \
--l-distr fixed --longitude 145.45077514648438 --latitude -5.2039947509765625 --i-distr uniform \
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
