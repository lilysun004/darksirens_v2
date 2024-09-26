lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 21.53013013013013 --fixed-mass2 71.87251251251251 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029804485.559878 \
--gps-end-time 1029811685.559878 \
--d-distr volume \
--min-distance 1470.6400223956264e3 --max-distance 1470.6600223956264e3 \
--l-distr fixed --longitude 171.4140625 --latitude 7.3443403244018555 --i-distr uniform \
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
