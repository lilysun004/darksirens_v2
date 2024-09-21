lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 47.91995995995996 --fixed-mass2 61.871271271271276 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1028318090.997671 \
--gps-end-time 1028325290.997671 \
--d-distr volume \
--min-distance 2960.18770959135e3 --max-distance 2960.2077095913505e3 \
--l-distr fixed --longitude 66.28377532958984 --latitude 45.458866119384766 --i-distr uniform \
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
