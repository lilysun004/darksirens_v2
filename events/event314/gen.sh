lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 39.095335335335335 --fixed-mass2 34.55695695695696 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018172440.9870524 \
--gps-end-time 1018179640.9870524 \
--d-distr volume \
--min-distance 1189.8931101557248e3 --max-distance 1189.9131101557248e3 \
--l-distr fixed --longitude -96.09677124023438 --latitude -5.8838396072387695 --i-distr uniform \
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
