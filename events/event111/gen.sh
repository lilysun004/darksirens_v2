lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 30.354754754754754 --fixed-mass2 29.178138138138138 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005772969.5225636 \
--gps-end-time 1005780169.5225636 \
--d-distr volume \
--min-distance 2095.8763980388144e3 --max-distance 2095.896398038815e3 \
--l-distr fixed --longitude 77.76213836669922 --latitude -70.6375961303711 --i-distr uniform \
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
