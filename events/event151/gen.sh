lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 55.23179179179179 --fixed-mass2 69.77141141141142 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1004816188.7510777 \
--gps-end-time 1004823388.7510777 \
--d-distr volume \
--min-distance 3606.69594862012e3 --max-distance 3606.7159486201203e3 \
--l-distr fixed --longitude -158.29348754882812 --latitude -5.856919288635254 --i-distr uniform \
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
