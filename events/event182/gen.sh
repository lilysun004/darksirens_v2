lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 18.924764764764763 --fixed-mass2 83.55463463463464 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026811514.9685749 \
--gps-end-time 1026818714.9685749 \
--d-distr volume \
--min-distance 1304.4069950482415e3 --max-distance 1304.4269950482415e3 \
--l-distr fixed --longitude -37.38507080078125 --latitude 19.04070281982422 --i-distr uniform \
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
