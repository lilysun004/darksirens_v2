lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 47.91995995995996 --fixed-mass2 60.35847847847848 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007456815.7821286 \
--gps-end-time 1007464015.7821286 \
--d-distr volume \
--min-distance 2160.5335280544764e3 --max-distance 2160.553528054477e3 \
--l-distr fixed --longitude 35.258174896240234 --latitude 59.346946716308594 --i-distr uniform \
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
