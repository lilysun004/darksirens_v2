lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 19.092852852852854 --fixed-mass2 66.82986986986987 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009289142.0889032 \
--gps-end-time 1009296342.0889032 \
--d-distr volume \
--min-distance 1146.6922336788832e3 --max-distance 1146.7122336788832e3 \
--l-distr fixed --longitude 54.878089904785156 --latitude 45.63273620605469 --i-distr uniform \
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
