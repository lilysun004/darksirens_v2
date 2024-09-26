lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 19.849249249249247 --fixed-mass2 77.67155155155156 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020616675.4070125 \
--gps-end-time 1020623875.4070125 \
--d-distr volume \
--min-distance 1087.7349287246789e3 --max-distance 1087.7549287246788e3 \
--l-distr fixed --longitude 17.405221939086914 --latitude 14.959787368774414 --i-distr uniform \
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
