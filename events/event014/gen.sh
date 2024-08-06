lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.3193993993994 --fixed-mass2 9.763963963963963 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026880053.8651129 \
--gps-end-time 1026887253.8651129 \
--d-distr volume \
--min-distance 1461.657131163226e3 --max-distance 1461.677131163226e3 \
--l-distr fixed --longitude -122.23583984375 --latitude 15.424813270568848 --i-distr uniform \
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
