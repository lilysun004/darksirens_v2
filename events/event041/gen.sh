lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 27.74938938938939 --fixed-mass2 61.11487487487488 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021386086.6761183 \
--gps-end-time 1021393286.6761183 \
--d-distr volume \
--min-distance 1392.4812915702769e3 --max-distance 1392.5012915702769e3 \
--l-distr fixed --longitude 125.84323120117188 --latitude -79.68067932128906 --i-distr uniform \
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
