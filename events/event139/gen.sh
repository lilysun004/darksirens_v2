lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 31.699459459459458 --fixed-mass2 37.41445445445446 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014639217.9722723 \
--gps-end-time 1014646417.9722723 \
--d-distr volume \
--min-distance 578.1180940495792e3 --max-distance 578.1380940495792e3 \
--l-distr fixed --longitude 127.57974243164062 --latitude 57.889827728271484 --i-distr uniform \
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
