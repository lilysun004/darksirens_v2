lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 37.4984984984985 --fixed-mass2 75.73853853853853 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002754046.2823875 \
--gps-end-time 1002761246.2823875 \
--d-distr volume \
--min-distance 1862.950105117619e3 --max-distance 1862.970105117619e3 \
--l-distr fixed --longitude 64.94588470458984 --latitude 13.238788604736328 --i-distr uniform \
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
