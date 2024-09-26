lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 26.908948948948947 --fixed-mass2 31.363283283283284 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1028514358.4294567 \
--gps-end-time 1028521558.4294567 \
--d-distr volume \
--min-distance 1698.6600041904694e3 --max-distance 1698.6800041904694e3 \
--l-distr fixed --longitude 15.379746437072754 --latitude -45.44242858886719 --i-distr uniform \
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
