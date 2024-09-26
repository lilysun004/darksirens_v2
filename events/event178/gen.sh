lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 12.621461461461461 --fixed-mass2 32.96012012012012 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009796373.3357366 \
--gps-end-time 1009803573.3357366 \
--d-distr volume \
--min-distance 958.1016933123532e3 --max-distance 958.1216933123532e3 \
--l-distr fixed --longitude -149.05992126464844 --latitude -45.22342300415039 --i-distr uniform \
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
