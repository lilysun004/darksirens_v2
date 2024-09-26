lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.04168168168168 --fixed-mass2 80.78118118118118 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1004806077.3343239 \
--gps-end-time 1004813277.3343239 \
--d-distr volume \
--min-distance 1245.1227692659816e3 --max-distance 1245.1427692659815e3 \
--l-distr fixed --longitude 61.29194259643555 --latitude -3.7150917053222656 --i-distr uniform \
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
