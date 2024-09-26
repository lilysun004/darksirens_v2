lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 69.26714714714716 --fixed-mass2 82.79823823823824 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1012499162.7249027 \
--gps-end-time 1012506362.7249027 \
--d-distr volume \
--min-distance 2418.885687496174e3 --max-distance 2418.9056874961743e3 \
--l-distr fixed --longitude -124.96357727050781 --latitude -55.937896728515625 --i-distr uniform \
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
