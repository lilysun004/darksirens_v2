lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.73961961961962 --fixed-mass2 72.46082082082083 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018577752.505343 \
--gps-end-time 1018584952.505343 \
--d-distr volume \
--min-distance 1343.5937903471633e3 --max-distance 1343.6137903471633e3 \
--l-distr fixed --longitude -142.43328857421875 --latitude 47.79403305053711 --i-distr uniform \
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
