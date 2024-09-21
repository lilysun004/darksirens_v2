lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 21.277997997997996 --fixed-mass2 73.04912912912913 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023399569.6085178 \
--gps-end-time 1023406769.6085178 \
--d-distr volume \
--min-distance 1855.503313971803e3 --max-distance 1855.523313971803e3 \
--l-distr fixed --longitude 150.54852294921875 --latitude -26.89614486694336 --i-distr uniform \
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
