lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 33.80056056056056 --fixed-mass2 76.2428028028028 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001824131.2777041 \
--gps-end-time 1001831331.2777041 \
--d-distr volume \
--min-distance 1533.8595911834097e3 --max-distance 1533.8795911834097e3 \
--l-distr fixed --longitude 45.59052658081055 --latitude 42.921783447265625 --i-distr uniform \
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
