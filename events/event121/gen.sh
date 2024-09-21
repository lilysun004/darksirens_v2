lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 7.830950950950951 --fixed-mass2 72.71295295295296 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026326164.1365298 \
--gps-end-time 1026333364.1365298 \
--d-distr volume \
--min-distance 708.9186269051187e3 --max-distance 708.9386269051187e3 \
--l-distr fixed --longitude -98.75921630859375 --latitude 70.30178833007812 --i-distr uniform \
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
