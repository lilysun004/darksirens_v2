lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 30.27071071071071 --fixed-mass2 56.15627627627628 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005329962.4845037 \
--gps-end-time 1005337162.4845037 \
--d-distr volume \
--min-distance 1278.2779987320334e3 --max-distance 1278.2979987320334e3 \
--l-distr fixed --longitude 18.90667724609375 --latitude -53.42306137084961 --i-distr uniform \
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
