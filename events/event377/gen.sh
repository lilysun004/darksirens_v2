lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 30.27071071071071 --fixed-mass2 55.567967967967974 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024475531.8530555 \
--gps-end-time 1024482731.8530555 \
--d-distr volume \
--min-distance 568.6540310774402e3 --max-distance 568.6740310774402e3 \
--l-distr fixed --longitude -122.67550659179688 --latitude -2.5430238246917725 --i-distr uniform \
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
