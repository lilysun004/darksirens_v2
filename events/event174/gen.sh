lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.823663663663663 --fixed-mass2 77.1672872872873 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024337910.9591317 \
--gps-end-time 1024345110.9591317 \
--d-distr volume \
--min-distance 814.0638538628837e3 --max-distance 814.0838538628836e3 \
--l-distr fixed --longitude -152.72804260253906 --latitude -4.029932498931885 --i-distr uniform \
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
