lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 7.830950950950951 --fixed-mass2 69.18310310310311 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006037435.2159431 \
--gps-end-time 1006044635.2159431 \
--d-distr volume \
--min-distance 1413.9299253956785e3 --max-distance 1413.9499253956785e3 \
--l-distr fixed --longitude -86.6141357421875 --latitude 56.638946533203125 --i-distr uniform \
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
