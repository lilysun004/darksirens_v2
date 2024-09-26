lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 9.007567567567568 --fixed-mass2 60.778698698698705 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002277195.71469 \
--gps-end-time 1002284395.71469 \
--d-distr volume \
--min-distance 1019.245870113365e3 --max-distance 1019.2658701133649e3 \
--l-distr fixed --longitude 165.36679077148438 --latitude 25.27323341369629 --i-distr uniform \
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
