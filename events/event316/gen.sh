lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 15.310870870870872 --fixed-mass2 81.2014014014014 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007222813.9052635 \
--gps-end-time 1007230013.9052635 \
--d-distr volume \
--min-distance 1359.2184188358178e3 --max-distance 1359.2384188358178e3 \
--l-distr fixed --longitude -110.58865356445312 --latitude 73.3595962524414 --i-distr uniform \
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
