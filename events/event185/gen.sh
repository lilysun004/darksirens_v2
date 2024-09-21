lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 8.839479479479479 --fixed-mass2 51.02958958958959 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019944275.1963205 \
--gps-end-time 1019951475.1963205 \
--d-distr volume \
--min-distance 1408.4821461556537e3 --max-distance 1408.5021461556537e3 \
--l-distr fixed --longitude 43.96930694580078 --latitude 29.314321517944336 --i-distr uniform \
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
