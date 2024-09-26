lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 12.873593593593593 --fixed-mass2 53.21473473473474 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005066362.7374383 \
--gps-end-time 1005073562.7374383 \
--d-distr volume \
--min-distance 1194.4406112390127e3 --max-distance 1194.4606112390127e3 \
--l-distr fixed --longitude 74.60485076904297 --latitude 1.0546822547912598 --i-distr uniform \
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
