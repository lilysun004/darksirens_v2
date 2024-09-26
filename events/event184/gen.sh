lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 34.72504504504505 --fixed-mass2 51.533853853853856 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001407596.5125515 \
--gps-end-time 1001414796.5125515 \
--d-distr volume \
--min-distance 2493.5640235036512e3 --max-distance 2493.5840235036517e3 \
--l-distr fixed --longitude -150.351318359375 --latitude -19.491390228271484 --i-distr uniform \
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
