lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 26.236596596596595 --fixed-mass2 38.59107107107108 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1031413590.9555562 \
--gps-end-time 1031420790.9555562 \
--d-distr volume \
--min-distance 2422.6857051995485e3 --max-distance 2422.705705199549e3 \
--l-distr fixed --longitude -91.82232666015625 --latitude -29.20185089111328 --i-distr uniform \
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
