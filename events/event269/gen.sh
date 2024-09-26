lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 25.90042042042042 --fixed-mass2 51.19767767767768 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021289155.2540663 \
--gps-end-time 1021296355.2540663 \
--d-distr volume \
--min-distance 1124.8320014780782e3 --max-distance 1124.8520014780781e3 \
--l-distr fixed --longitude -84.42218017578125 --latitude 23.14419174194336 --i-distr uniform \
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
