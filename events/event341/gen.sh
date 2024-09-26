lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 43.12944944944945 --fixed-mass2 10.52036036036036 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010081596.8391069 \
--gps-end-time 1010088796.8391069 \
--d-distr volume \
--min-distance 609.4622778725084e3 --max-distance 609.4822778725083e3 \
--l-distr fixed --longitude 25.958024978637695 --latitude 16.408340454101562 --i-distr uniform \
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
