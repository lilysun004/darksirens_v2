lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 19.176896896896896 --fixed-mass2 64.05641641641641 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014758243.6927046 \
--gps-end-time 1014765443.6927046 \
--d-distr volume \
--min-distance 2244.9589290429126e3 --max-distance 2244.978929042913e3 \
--l-distr fixed --longitude 60.8548698425293 --latitude 56.32183074951172 --i-distr uniform \
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
