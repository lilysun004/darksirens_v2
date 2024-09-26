lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 28.337697697697696 --fixed-mass2 42.62518518518519 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025585160.278025 \
--gps-end-time 1025592360.278025 \
--d-distr volume \
--min-distance 3771.00940070407e3 --max-distance 3771.02940070407e3 \
--l-distr fixed --longitude -24.075653076171875 --latitude -67.4131088256836 --i-distr uniform \
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
