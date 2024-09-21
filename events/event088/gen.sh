lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 41.53261261261262 --fixed-mass2 21.866306306306306 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1004846140.6218415 \
--gps-end-time 1004853340.6218415 \
--d-distr volume \
--min-distance 1683.9406852915802e3 --max-distance 1683.9606852915801e3 \
--l-distr fixed --longitude -144.42921447753906 --latitude -12.208539009094238 --i-distr uniform \
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
