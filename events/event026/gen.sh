lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 23.463143143143142 --fixed-mass2 60.862742742742746 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026950902.5310423 \
--gps-end-time 1026958102.5310423 \
--d-distr volume \
--min-distance 2675.302705125864e3 --max-distance 2675.3227051258646e3 \
--l-distr fixed --longitude -10.734649658203125 --latitude 12.59589672088623 --i-distr uniform \
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
