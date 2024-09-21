lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 18.67263263263263 --fixed-mass2 58.677597597597604 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009649608.4986781 \
--gps-end-time 1009656808.4986781 \
--d-distr volume \
--min-distance 3011.022227363922e3 --max-distance 3011.0422273639224e3 \
--l-distr fixed --longitude 94.51202392578125 --latitude -24.383453369140625 --i-distr uniform \
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
