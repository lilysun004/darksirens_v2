lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 29.766446446446444 --fixed-mass2 44.222022022022024 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022351593.1715126 \
--gps-end-time 1022358793.1715126 \
--d-distr volume \
--min-distance 1188.2287128559178e3 --max-distance 1188.2487128559178e3 \
--l-distr fixed --longitude -25.35723876953125 --latitude -63.02562713623047 --i-distr uniform \
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
