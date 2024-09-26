lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 39.85173173173173 --fixed-mass2 50.525325325325326 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006151686.6935645 \
--gps-end-time 1006158886.6935645 \
--d-distr volume \
--min-distance 1797.5415413732226e3 --max-distance 1797.5615413732226e3 \
--l-distr fixed --longitude -118.1131591796875 --latitude -10.488012313842773 --i-distr uniform \
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
