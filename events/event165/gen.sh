lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 3.3766166166166167 --fixed-mass2 70.02354354354355 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1028759910.1481398 \
--gps-end-time 1028767110.1481398 \
--d-distr volume \
--min-distance 337.1834189807015e3 --max-distance 337.2034189807015e3 \
--l-distr fixed --longitude 51.6655387878418 --latitude 55.73854446411133 --i-distr uniform \
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
