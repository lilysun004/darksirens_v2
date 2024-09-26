lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.90166166166166 --fixed-mass2 75.6544944944945 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025626078.5505735 \
--gps-end-time 1025633278.5505735 \
--d-distr volume \
--min-distance 3938.543176947176e3 --max-distance 3938.5631769471765e3 \
--l-distr fixed --longitude 156.01162719726562 --latitude 61.1621208190918 --i-distr uniform \
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
