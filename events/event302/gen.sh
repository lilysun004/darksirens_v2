lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 27.16108108108108 --fixed-mass2 37.66658658658659 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021942113.5152473 \
--gps-end-time 1021949313.5152473 \
--d-distr volume \
--min-distance 852.6858006208498e3 --max-distance 852.7058006208498e3 \
--l-distr fixed --longitude -40.295654296875 --latitude 7.843099117279053 --i-distr uniform \
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
