lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 10.100140140140141 --fixed-mass2 17.075795795795795 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009658978.9557356 \
--gps-end-time 1009666178.9557356 \
--d-distr volume \
--min-distance 541.1535686235869e3 --max-distance 541.1735686235869e3 \
--l-distr fixed --longitude -155.15328979492188 --latitude 76.6623764038086 --i-distr uniform \
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
