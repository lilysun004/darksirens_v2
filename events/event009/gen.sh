lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 11.865065065065064 --fixed-mass2 49.5167967967968 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018953885.7031866 \
--gps-end-time 1018961085.7031866 \
--d-distr volume \
--min-distance 488.0020168079508e3 --max-distance 488.02201680795076e3 \
--l-distr fixed --longitude 12.640565872192383 --latitude -68.45962524414062 --i-distr uniform \
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
