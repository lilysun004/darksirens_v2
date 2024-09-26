lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 11.444844844844845 --fixed-mass2 60.27443443443444 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005094760.6556587 \
--gps-end-time 1005101960.6556587 \
--d-distr volume \
--min-distance 1332.123296493696e3 --max-distance 1332.143296493696e3 \
--l-distr fixed --longitude -159.5550994873047 --latitude 60.77186584472656 --i-distr uniform \
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
