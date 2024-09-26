lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 6.654334334334335 --fixed-mass2 38.338938938938945 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002715403.4883765 \
--gps-end-time 1002722603.4883765 \
--d-distr volume \
--min-distance 534.8529777308663e3 --max-distance 534.8729777308663e3 \
--l-distr fixed --longitude -138.11068725585938 --latitude 16.651765823364258 --i-distr uniform \
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
