lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 25.73233233233233 --fixed-mass2 58.677597597597604 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024276449.267013 \
--gps-end-time 1024283649.267013 \
--d-distr volume \
--min-distance 1235.1470131405022e3 --max-distance 1235.1670131405021e3 \
--l-distr fixed --longitude -9.248626708984375 --latitude -65.37567138671875 --i-distr uniform \
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
