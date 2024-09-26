lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 29.598358358358357 --fixed-mass2 52.12216216216216 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027869646.1336068 \
--gps-end-time 1027876846.1336068 \
--d-distr volume \
--min-distance 2853.7352968188006e3 --max-distance 2853.755296818801e3 \
--l-distr fixed --longitude 36.40951156616211 --latitude -12.32675838470459 --i-distr uniform \
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
