lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 11.781021021021022 --fixed-mass2 63.55215215215215 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021234837.0180235 \
--gps-end-time 1021242037.0180235 \
--d-distr volume \
--min-distance 1648.5088121465e3 --max-distance 1648.5288121465e3 \
--l-distr fixed --longitude -101.52621459960938 --latitude 14.904633522033691 --i-distr uniform \
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
