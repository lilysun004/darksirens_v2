lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 25.564244244244243 --fixed-mass2 74.39383383383384 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023504215.2844999 \
--gps-end-time 1023511415.2844999 \
--d-distr volume \
--min-distance 2314.00335032773e3 --max-distance 2314.0233503277304e3 \
--l-distr fixed --longitude 113.87606811523438 --latitude 29.913156509399414 --i-distr uniform \
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
