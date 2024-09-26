lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 28.84196196196196 --fixed-mass2 80.02478478478479 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018539841.4591349 \
--gps-end-time 1018547041.4591349 \
--d-distr volume \
--min-distance 1452.6395353295873e3 --max-distance 1452.6595353295872e3 \
--l-distr fixed --longitude -56.757110595703125 --latitude -48.800350189208984 --i-distr uniform \
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
