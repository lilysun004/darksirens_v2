lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.125725725725726 --fixed-mass2 41.280480480480485 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023649111.1020943 \
--gps-end-time 1023656311.1020943 \
--d-distr volume \
--min-distance 1621.560224608744e3 --max-distance 1621.580224608744e3 \
--l-distr fixed --longitude -106.5550537109375 --latitude -57.428287506103516 --i-distr uniform \
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
