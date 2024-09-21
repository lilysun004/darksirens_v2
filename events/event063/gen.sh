lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 38.75915915915916 --fixed-mass2 38.08680680680681 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025793520.6988496 \
--gps-end-time 1025800720.6988496 \
--d-distr volume \
--min-distance 1990.5688222226822e3 --max-distance 1990.5888222226822e3 \
--l-distr fixed --longitude 98.96295166015625 --latitude 4.692883491516113 --i-distr uniform \
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
