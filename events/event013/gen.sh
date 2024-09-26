lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 46.491211211211215 --fixed-mass2 61.11487487487488 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000537339.0230312 \
--gps-end-time 1000544539.0230312 \
--d-distr volume \
--min-distance 3220.3604881747915e3 --max-distance 3220.380488174792e3 \
--l-distr fixed --longitude -63.18975830078125 --latitude -2.082440137863159 --i-distr uniform \
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
