lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 52.710470470470476 --fixed-mass2 49.09657657657658 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002763768.8285666 \
--gps-end-time 1002770968.8285666 \
--d-distr volume \
--min-distance 2901.803559309784e3 --max-distance 2901.8235593097843e3 \
--l-distr fixed --longitude -97.31851196289062 --latitude -77.12091827392578 --i-distr uniform \
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
