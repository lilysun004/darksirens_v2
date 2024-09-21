lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 24.21953953953954 --fixed-mass2 67.8383983983984 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021143967.3536565 \
--gps-end-time 1021151167.3536565 \
--d-distr volume \
--min-distance 2734.680888760934e3 --max-distance 2734.7008887609345e3 \
--l-distr fixed --longitude 40.053932189941406 --latitude 36.901668548583984 --i-distr uniform \
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
