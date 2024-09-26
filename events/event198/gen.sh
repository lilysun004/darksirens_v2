lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 20.353513513513512 --fixed-mass2 76.91515515515516 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001731130.917272 \
--gps-end-time 1001738330.917272 \
--d-distr volume \
--min-distance 744.9129318697744e3 --max-distance 744.9329318697744e3 \
--l-distr fixed --longitude 103.73057556152344 --latitude -50.05583572387695 --i-distr uniform \
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
