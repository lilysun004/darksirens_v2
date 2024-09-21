lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.293813813813813 --fixed-mass2 48.17209209209209 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001870930.3588564 \
--gps-end-time 1001878130.3588564 \
--d-distr volume \
--min-distance 1344.9883429340248e3 --max-distance 1345.0083429340248e3 \
--l-distr fixed --longitude 161.75491333007812 --latitude 74.83717346191406 --i-distr uniform \
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
