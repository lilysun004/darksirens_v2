lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 32.035635635635636 --fixed-mass2 77.25133133133133 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007450001.7930619 \
--gps-end-time 1007457201.7930619 \
--d-distr volume \
--min-distance 1781.5352436186993e3 --max-distance 1781.5552436186993e3 \
--l-distr fixed --longitude 91.23592376708984 --latitude 50.51414489746094 --i-distr uniform \
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
