lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 27.32916916916917 --fixed-mass2 78.51199199199199 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1011625195.9349737 \
--gps-end-time 1011632395.9349737 \
--d-distr volume \
--min-distance 2464.0516209564958e3 --max-distance 2464.071620956496e3 \
--l-distr fixed --longitude -47.54364013671875 --latitude 36.76385498046875 --i-distr uniform \
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
