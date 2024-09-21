lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 12.873593593593593 --fixed-mass2 85.99191191191191 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006364938.6745566 \
--gps-end-time 1006372138.6745566 \
--d-distr volume \
--min-distance 1121.964588627563e3 --max-distance 1121.984588627563e3 \
--l-distr fixed --longitude -9.65234375 --latitude 14.087632179260254 --i-distr uniform \
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
