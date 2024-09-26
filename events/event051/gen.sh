lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 37.24636636636637 --fixed-mass2 66.3256056056056 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000978667.7515496 \
--gps-end-time 1000985867.7515496 \
--d-distr volume \
--min-distance 1269.9657399234748e3 --max-distance 1269.9857399234747e3 \
--l-distr fixed --longitude -105.46762084960938 --latitude 33.80387496948242 --i-distr uniform \
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
