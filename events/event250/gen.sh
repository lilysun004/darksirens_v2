lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 31.11115115115115 --fixed-mass2 48.67635635635636 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019861131.5105219 \
--gps-end-time 1019868331.5105219 \
--d-distr volume \
--min-distance 1943.6914376188677e3 --max-distance 1943.7114376188676e3 \
--l-distr fixed --longitude -2.628173828125 --latitude 66.16305541992188 --i-distr uniform \
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
