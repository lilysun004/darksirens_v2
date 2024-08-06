lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.545945945945945 --fixed-mass2 47.24760760760761 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008879073.3728226 \
--gps-end-time 1008886273.3728226 \
--d-distr volume \
--min-distance 1202.0521839480323e3 --max-distance 1202.0721839480323e3 \
--l-distr fixed --longitude 31.082088470458984 --latitude -71.9745101928711 --i-distr uniform \
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
