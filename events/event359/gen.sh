lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 32.96012012012012 --fixed-mass2 77.92368368368369 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001806003.0544502 \
--gps-end-time 1001813203.0544502 \
--d-distr volume \
--min-distance 2795.6206744601195e3 --max-distance 2795.64067446012e3 \
--l-distr fixed --longitude -104.87109375 --latitude 49.705936431884766 --i-distr uniform \
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
