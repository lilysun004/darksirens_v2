lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 36.57401401401402 --fixed-mass2 79.43647647647649 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020995602.7296188 \
--gps-end-time 1021002802.7296188 \
--d-distr volume \
--min-distance 3685.217874277751e3 --max-distance 3685.2378742777514e3 \
--l-distr fixed --longitude 7.340479850769043 --latitude -41.31174087524414 --i-distr uniform \
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
