lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 10.436316316316315 --fixed-mass2 65.98942942942944 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1031455677.1798009 \
--gps-end-time 1031462877.1798009 \
--d-distr volume \
--min-distance 1219.0440622668857e3 --max-distance 1219.0640622668857e3 \
--l-distr fixed --longitude -50.94866943359375 --latitude -14.922237396240234 --i-distr uniform \
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
