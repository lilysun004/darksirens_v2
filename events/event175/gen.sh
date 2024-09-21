lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 9.343743743743744 --fixed-mass2 50.441281281281285 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026055668.0573951 \
--gps-end-time 1026062868.0573951 \
--d-distr volume \
--min-distance 1305.0215007698412e3 --max-distance 1305.0415007698412e3 \
--l-distr fixed --longitude 102.9964599609375 --latitude 47.93836975097656 --i-distr uniform \
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
