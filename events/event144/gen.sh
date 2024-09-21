lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 24.21953953953954 --fixed-mass2 65.7372972972973 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023531023.2323732 \
--gps-end-time 1023538223.2323732 \
--d-distr volume \
--min-distance 2517.1241357464137e3 --max-distance 2517.144135746414e3 \
--l-distr fixed --longitude -156.16204833984375 --latitude -55.9632568359375 --i-distr uniform \
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
