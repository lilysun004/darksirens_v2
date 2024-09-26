lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 14.63851851851852 --fixed-mass2 76.2428028028028 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1030535688.6160246 \
--gps-end-time 1030542888.6160246 \
--d-distr volume \
--min-distance 1484.0229656704225e3 --max-distance 1484.0429656704225e3 \
--l-distr fixed --longitude 7.930550575256348 --latitude -16.75653076171875 --i-distr uniform \
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
