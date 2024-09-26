lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 23.547187187187188 --fixed-mass2 52.45833833833834 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029111330.1901426 \
--gps-end-time 1029118530.1901426 \
--d-distr volume \
--min-distance 731.0235537220694e3 --max-distance 731.0435537220694e3 \
--l-distr fixed --longitude -160.69622802734375 --latitude 5.554169178009033 --i-distr uniform \
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
