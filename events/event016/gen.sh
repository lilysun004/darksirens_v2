lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 8.167127127127127 --fixed-mass2 31.363283283283284 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019445293.9514017 \
--gps-end-time 1019452493.9514017 \
--d-distr volume \
--min-distance 883.8707902653446e3 --max-distance 883.8907902653445e3 \
--l-distr fixed --longitude 139.35018920898438 --latitude 58.12556457519531 --i-distr uniform \
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
