lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 46.23907907907908 --fixed-mass2 65.98942942942944 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002415487.0087032 \
--gps-end-time 1002422687.0087032 \
--d-distr volume \
--min-distance 1668.028405251705e3 --max-distance 1668.048405251705e3 \
--l-distr fixed --longitude 23.890005111694336 --latitude -2.31773042678833 --i-distr uniform \
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
