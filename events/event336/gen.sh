lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 27.32916916916917 --fixed-mass2 49.5167967967968 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1011673719.3631717 \
--gps-end-time 1011680919.3631717 \
--d-distr volume \
--min-distance 2245.2966086664765e3 --max-distance 2245.316608666477e3 \
--l-distr fixed --longitude -37.3035888671875 --latitude -54.20380401611328 --i-distr uniform \
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
