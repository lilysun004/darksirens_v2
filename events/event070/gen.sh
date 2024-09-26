lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.48144144144145 --fixed-mass2 68.67883883883884 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000612417.9093965 \
--gps-end-time 1000619617.9093965 \
--d-distr volume \
--min-distance 1379.5948325761897e3 --max-distance 1379.6148325761897e3 \
--l-distr fixed --longitude 76.98799896240234 --latitude -62.806819915771484 --i-distr uniform \
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
