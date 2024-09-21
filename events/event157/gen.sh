lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 33.212252252252256 --fixed-mass2 65.06494494494494 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010106547.2769351 \
--gps-end-time 1010113747.2769351 \
--d-distr volume \
--min-distance 893.5953228955817e3 --max-distance 893.6153228955817e3 \
--l-distr fixed --longitude -142.91656494140625 --latitude -13.804879188537598 --i-distr uniform \
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
