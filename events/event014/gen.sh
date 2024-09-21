lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 31.699459459459458 --fixed-mass2 7.914994994994995 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021511631.3418092 \
--gps-end-time 1021518831.3418092 \
--d-distr volume \
--min-distance 6325.8768360788745e3 --max-distance 6325.896836078875e3 \
--l-distr fixed --longitude -13.804931640625 --latitude -56.763912200927734 --i-distr uniform \
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
