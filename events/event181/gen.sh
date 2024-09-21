lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 39.431511511511516 --fixed-mass2 79.01625625625626 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008547694.7237465 \
--gps-end-time 1008554894.7237465 \
--d-distr volume \
--min-distance 2740.3598575239735e3 --max-distance 2740.379857523974e3 \
--l-distr fixed --longitude -93.61215209960938 --latitude -44.54109191894531 --i-distr uniform \
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
