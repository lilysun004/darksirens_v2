lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 17.916236236236237 --fixed-mass2 77.58750750750751 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022665975.8363247 \
--gps-end-time 1022673175.8363247 \
--d-distr volume \
--min-distance 2010.74576633245e3 --max-distance 2010.76576633245e3 \
--l-distr fixed --longitude -158.6615447998047 --latitude -51.34596633911133 --i-distr uniform \
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
