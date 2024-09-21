lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 23.21101101101101 --fixed-mass2 85.40360360360361 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025341957.6240566 \
--gps-end-time 1025349157.6240566 \
--d-distr volume \
--min-distance 1696.1958036186106e3 --max-distance 1696.2158036186106e3 \
--l-distr fixed --longitude -103.12725830078125 --latitude -2.8211443424224854 --i-distr uniform \
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
