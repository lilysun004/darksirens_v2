lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 20.353513513513512 --fixed-mass2 18.58858858858859 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009859235.3435745 \
--gps-end-time 1009866435.3435745 \
--d-distr volume \
--min-distance 1901.067572353315e3 --max-distance 1901.087572353315e3 \
--l-distr fixed --longitude 20.830303192138672 --latitude 69.37618255615234 --i-distr uniform \
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
