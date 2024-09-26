lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 8.671391391391392 --fixed-mass2 53.88708708708709 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014020570.6261011 \
--gps-end-time 1014027770.6261011 \
--d-distr volume \
--min-distance 749.5662428781624e3 --max-distance 749.5862428781624e3 \
--l-distr fixed --longitude -159.35394287109375 --latitude 26.693992614746094 --i-distr uniform \
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
