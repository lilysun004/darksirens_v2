lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 40.77621621621622 --fixed-mass2 63.888328328328335 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000000000 \
--gps-end-time 1000007200 \
--d-distr volume \
--min-distance 566.6701081894092e3 --max-distance 566.6901081894092e3 \
--l-distr fixed --longitude 69.7683334350586 --latitude 19.74549674987793 --i-distr uniform \
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
