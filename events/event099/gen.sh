lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 11.276756756756757 --fixed-mass2 49.68488488488489 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025845461.8738763 \
--gps-end-time 1025852661.8738763 \
--d-distr volume \
--min-distance 925.9762218484535e3 --max-distance 925.9962218484535e3 \
--l-distr fixed --longitude 16.195064544677734 --latitude -4.534551620483398 --i-distr uniform \
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
