lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 5.1415415415415415 --fixed-mass2 85.65573573573575 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1028994876.0425893 \
--gps-end-time 1029002076.0425893 \
--d-distr volume \
--min-distance 537.9472738953374e3 --max-distance 537.9672738953374e3 \
--l-distr fixed --longitude -45.70361328125 --latitude -38.736385345458984 --i-distr uniform \
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
