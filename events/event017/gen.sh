lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 44.306066066066066 --fixed-mass2 60.778698698698705 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009707751.2212218 \
--gps-end-time 1009714951.2212218 \
--d-distr volume \
--min-distance 2082.8151993422043e3 --max-distance 2082.8351993422048e3 \
--l-distr fixed --longitude 144.2142333984375 --latitude 53.09510803222656 --i-distr uniform \
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
