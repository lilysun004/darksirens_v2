lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 7.6628628628628634 --fixed-mass2 54.81157157157158 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000000000 \
--gps-end-time 1000007200 \
--d-distr volume \
--min-distance 593.4563667729628e3 --max-distance 593.4763667729628e3 \
--l-distr fixed --longitude 24.62074089050293 --latitude 15.694839477539062 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--E1=EinsteinTelescopeP1600143 \
--E2=EinsteinTelescopeP1600143 \
--E3=EinsteinTelescopeP1600143 \
--X1=CosmicExplorerP1600143

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector E1 E2 E3 X1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
