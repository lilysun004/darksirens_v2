lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 22.11843843843844 --fixed-mass2 51.02958958958959 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000000000 \
--gps-end-time 1000007200 \
--d-distr volume \
--min-distance 663.7451374833599e3 --max-distance 663.7651374833599e3 \
--l-distr fixed --longitude 63.75236129760742 --latitude 26.122533798217773 --i-distr uniform \
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
