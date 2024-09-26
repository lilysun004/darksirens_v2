lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 45.90290290290291 --fixed-mass2 48.67635635635636 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019644041.5049777 \
--gps-end-time 1019651241.5049777 \
--d-distr volume \
--min-distance 1832.867059513556e3 --max-distance 1832.8870595135559e3 \
--l-distr fixed --longitude 23.78018569946289 --latitude -10.481582641601562 --i-distr uniform \
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
