lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 32.203723723723726 --fixed-mass2 59.85421421421422 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016515896.8155129 \
--gps-end-time 1016523096.8155129 \
--d-distr volume \
--min-distance 2047.7264933374083e3 --max-distance 2047.7464933374083e3 \
--l-distr fixed --longitude -18.801025390625 --latitude -75.83477783203125 --i-distr uniform \
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
