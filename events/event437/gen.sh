lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 28.673873873873873 --fixed-mass2 38.42298298298299 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027813731.6519743 \
--gps-end-time 1027820931.6519743 \
--d-distr volume \
--min-distance 1702.4950714947784e3 --max-distance 1702.5150714947783e3 \
--l-distr fixed --longitude 130.83094787597656 --latitude -65.37841033935547 --i-distr uniform \
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
