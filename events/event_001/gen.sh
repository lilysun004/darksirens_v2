lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.882122122122123 --fixed-mass2 39.095335335335335 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000000000 \
--gps-end-time 1000007200 \
--d-distr volume \
--min-distance 410.2499322609259e3 --max-distance 410.2699322609259e3 \
--l-distr fixed --longitude 87.85055541992188 --latitude 14.979218482971191 --i-distr uniform \
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
