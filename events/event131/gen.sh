lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 45.98694694694695 --fixed-mass2 24.303583583583585 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014048492.9711921 \
--gps-end-time 1014055692.9711921 \
--d-distr volume \
--min-distance 866.304781018238e3 --max-distance 866.324781018238e3 \
--l-distr fixed --longitude -35.171783447265625 --latitude 32.91068649291992 --i-distr uniform \
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
