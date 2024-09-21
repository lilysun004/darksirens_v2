lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.81761761761762 --fixed-mass2 81.28544544544545 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1011423740.7110152 \
--gps-end-time 1011430940.7110152 \
--d-distr volume \
--min-distance 4050.5075496823692e3 --max-distance 4050.5275496823697e3 \
--l-distr fixed --longitude 139.6989288330078 --latitude 24.51669692993164 --i-distr uniform \
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
