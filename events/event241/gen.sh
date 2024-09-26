lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 22.79079079079079 --fixed-mass2 55.31583583583584 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025244743.02627 \
--gps-end-time 1025251943.02627 \
--d-distr volume \
--min-distance 1166.877419709365e3 --max-distance 1166.897419709365e3 \
--l-distr fixed --longitude -162.02708435058594 --latitude 6.5490946769714355 --i-distr uniform \
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
