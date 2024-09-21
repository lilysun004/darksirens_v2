lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 43.96988988988989 --fixed-mass2 80.02478478478479 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023818224.0020468 \
--gps-end-time 1023825424.0020468 \
--d-distr volume \
--min-distance 4621.483219104834e3 --max-distance 4621.503219104834e3 \
--l-distr fixed --longitude 99.60724639892578 --latitude 26.522647857666016 --i-distr uniform \
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
