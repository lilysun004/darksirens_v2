lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 33.80056056056056 --fixed-mass2 63.6361961961962 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019567515.5950569 \
--gps-end-time 1019574715.5950569 \
--d-distr volume \
--min-distance 2865.9388132368495e3 --max-distance 2865.95881323685e3 \
--l-distr fixed --longitude -112.1044921875 --latitude -33.75455856323242 --i-distr uniform \
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
