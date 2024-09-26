lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.73961961961962 --fixed-mass2 33.2962962962963 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016341220.1342868 \
--gps-end-time 1016348420.1342868 \
--d-distr volume \
--min-distance 1097.6796366997557e3 --max-distance 1097.6996366997557e3 \
--l-distr fixed --longitude -14.419189453125 --latitude -22.50640869140625 --i-distr uniform \
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
