lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 38.254894894894896 --fixed-mass2 71.11611611611612 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021068950.8733827 \
--gps-end-time 1021076150.8733827 \
--d-distr volume \
--min-distance 4704.204458703315e3 --max-distance 4704.224458703316e3 \
--l-distr fixed --longitude -156.96913146972656 --latitude 63.49033737182617 --i-distr uniform \
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
