lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 15.815135135135137 --fixed-mass2 48.17209209209209 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1012522161.4961581 \
--gps-end-time 1012529361.4961581 \
--d-distr volume \
--min-distance 1651.2334070619659e3 --max-distance 1651.2534070619658e3 \
--l-distr fixed --longitude -179.64511108398438 --latitude -10.423855781555176 --i-distr uniform \
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
