lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 21.36204204204204 --fixed-mass2 76.49493493493493 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009709766.2999127 \
--gps-end-time 1009716966.2999127 \
--d-distr volume \
--min-distance 2122.066578776529e3 --max-distance 2122.086578776529e3 \
--l-distr fixed --longitude 94.909912109375 --latitude 41.314849853515625 --i-distr uniform \
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
