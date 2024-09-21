lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.31335335335336 --fixed-mass2 48.00400400400401 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1012413395.0614088 \
--gps-end-time 1012420595.0614088 \
--d-distr volume \
--min-distance 4052.1002833712537e3 --max-distance 4052.120283371254e3 \
--l-distr fixed --longitude 107.08766174316406 --latitude -63.72831726074219 --i-distr uniform \
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
