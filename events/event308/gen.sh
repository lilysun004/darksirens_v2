lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 28.589829829829828 --fixed-mass2 12.033153153153155 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002595287.5958086 \
--gps-end-time 1002602487.5958086 \
--d-distr volume \
--min-distance 1047.9220382412616e3 --max-distance 1047.9420382412616e3 \
--l-distr fixed --longitude -9.340240478515625 --latitude -80.03844451904297 --i-distr uniform \
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
