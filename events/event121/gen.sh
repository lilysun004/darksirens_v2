lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 21.277997997997996 --fixed-mass2 48.25613613613614 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016180040.0438837 \
--gps-end-time 1016187240.0438837 \
--d-distr volume \
--min-distance 1083.9621695382668e3 --max-distance 1083.9821695382668e3 \
--l-distr fixed --longitude -164.80157470703125 --latitude 66.36991882324219 --i-distr uniform \
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
