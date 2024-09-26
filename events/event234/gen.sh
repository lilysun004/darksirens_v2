lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 49.76892892892893 --fixed-mass2 26.404684684684685 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002256467.5878522 \
--gps-end-time 1002263667.5878522 \
--d-distr volume \
--min-distance 933.1604923347062e3 --max-distance 933.1804923347062e3 \
--l-distr fixed --longitude -110.46685791015625 --latitude -11.153219223022461 --i-distr uniform \
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
