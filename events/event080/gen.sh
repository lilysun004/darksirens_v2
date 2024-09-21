lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 50.69341341341342 --fixed-mass2 42.204964964964965 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1028608467.5373845 \
--gps-end-time 1028615667.5373845 \
--d-distr volume \
--min-distance 2414.5211411058585e3 --max-distance 2414.541141105859e3 \
--l-distr fixed --longitude 131.59918212890625 --latitude 4.415637493133545 --i-distr uniform \
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
