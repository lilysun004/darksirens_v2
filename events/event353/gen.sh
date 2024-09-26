lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 25.05997997997998 --fixed-mass2 60.27443443443444 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016095312.1902703 \
--gps-end-time 1016102512.1902703 \
--d-distr volume \
--min-distance 1711.991517408423e3 --max-distance 1712.011517408423e3 \
--l-distr fixed --longitude -24.517181396484375 --latitude 49.20796585083008 --i-distr uniform \
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
