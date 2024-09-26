lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 6.822422422422423 --fixed-mass2 41.02834834834835 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025604418.1702296 \
--gps-end-time 1025611618.1702296 \
--d-distr volume \
--min-distance 585.3102191029644e3 --max-distance 585.3302191029644e3 \
--l-distr fixed --longitude 0.508115291595459 --latitude 56.766510009765625 --i-distr uniform \
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
