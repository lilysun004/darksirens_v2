lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 44.81033033033033 --fixed-mass2 51.449809809809814 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008647756.1702644 \
--gps-end-time 1008654956.1702644 \
--d-distr volume \
--min-distance 1842.3362835374505e3 --max-distance 1842.3562835374505e3 \
--l-distr fixed --longitude 73.05866241455078 --latitude 30.237083435058594 --i-distr uniform \
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
