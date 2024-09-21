lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 31.53137137137137 --fixed-mass2 21.69821821821822 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016127883.5301805 \
--gps-end-time 1016135083.5301805 \
--d-distr volume \
--min-distance 1325.8737104841719e3 --max-distance 1325.8937104841718e3 \
--l-distr fixed --longitude -48.49725341796875 --latitude 17.884105682373047 --i-distr uniform \
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
