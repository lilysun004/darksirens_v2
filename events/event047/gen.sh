lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 36.153793793793795 --fixed-mass2 83.13441441441442 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1012924817.2498412 \
--gps-end-time 1012932017.2498412 \
--d-distr volume \
--min-distance 3856.590205869249e3 --max-distance 3856.6102058692495e3 \
--l-distr fixed --longitude 167.90309143066406 --latitude -71.6949234008789 --i-distr uniform \
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
