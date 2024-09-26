lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 18.25241241241241 --fixed-mass2 35.98570570570571 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018531448.5089166 \
--gps-end-time 1018538648.5089166 \
--d-distr volume \
--min-distance 1513.607763657817e3 --max-distance 1513.627763657817e3 \
--l-distr fixed --longitude 71.6242904663086 --latitude -13.036319732666016 --i-distr uniform \
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
