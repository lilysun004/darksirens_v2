lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 32.79203203203203 --fixed-mass2 47.75187187187188 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1013086660.0661745 \
--gps-end-time 1013093860.0661745 \
--d-distr volume \
--min-distance 3166.2839588326187e3 --max-distance 3166.303958832619e3 \
--l-distr fixed --longitude -18.893402099609375 --latitude -53.928043365478516 --i-distr uniform \
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
