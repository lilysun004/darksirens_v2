lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 41.53261261261262 --fixed-mass2 83.3025025025025 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001715690.9791442 \
--gps-end-time 1001722890.9791442 \
--d-distr volume \
--min-distance 2495.8520348972183e3 --max-distance 2495.872034897219e3 \
--l-distr fixed --longitude -171.22889709472656 --latitude -63.226810455322266 --i-distr uniform \
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
