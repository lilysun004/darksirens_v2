lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 23.379099099099097 --fixed-mass2 24.89189189189189 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002623591.509061 \
--gps-end-time 1002630791.509061 \
--d-distr volume \
--min-distance 2944.534678583404e3 --max-distance 2944.5546785834044e3 \
--l-distr fixed --longitude 134.04046630859375 --latitude 66.20307922363281 --i-distr uniform \
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
