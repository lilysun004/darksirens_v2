lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.64952952952953 --fixed-mass2 48.592312312312316 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024703641.1188446 \
--gps-end-time 1024710841.1188446 \
--d-distr volume \
--min-distance 1800.418086525092e3 --max-distance 1800.4380865250919e3 \
--l-distr fixed --longitude 133.8973846435547 --latitude -50.767459869384766 --i-distr uniform \
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
