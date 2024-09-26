lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 11.52888888888889 --fixed-mass2 54.97965965965966 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008129568.1356229 \
--gps-end-time 1008136768.1356229 \
--d-distr volume \
--min-distance 1535.1780959487792e3 --max-distance 1535.1980959487792e3 \
--l-distr fixed --longitude -118.39486694335938 --latitude -70.78845977783203 --i-distr uniform \
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
