lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 4.88940940940941 --fixed-mass2 85.48764764764765 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009869029.8611145 \
--gps-end-time 1009876229.8611145 \
--d-distr volume \
--min-distance 590.4620724691978e3 --max-distance 590.4820724691978e3 \
--l-distr fixed --longitude 69.28160858154297 --latitude 18.579998016357422 --i-distr uniform \
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
