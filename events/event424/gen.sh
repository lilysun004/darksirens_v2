lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 33.96864864864865 --fixed-mass2 45.73481481481482 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1012652603.8024453 \
--gps-end-time 1012659803.8024453 \
--d-distr volume \
--min-distance 1686.1835627612068e3 --max-distance 1686.2035627612067e3 \
--l-distr fixed --longitude -20.8524169921875 --latitude -38.1763801574707 --i-distr uniform \
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
