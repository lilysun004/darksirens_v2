lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 32.62394394394394 --fixed-mass2 78.59603603603604 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020282606.569407 \
--gps-end-time 1020289806.569407 \
--d-distr volume \
--min-distance 2249.464384622198e3 --max-distance 2249.4843846221984e3 \
--l-distr fixed --longitude 92.59051513671875 --latitude -9.998298645019531 --i-distr uniform \
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
