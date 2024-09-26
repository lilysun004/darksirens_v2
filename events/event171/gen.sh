lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 23.88336336336336 --fixed-mass2 52.96260260260261 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025912153.272336 \
--gps-end-time 1025919353.272336 \
--d-distr volume \
--min-distance 2635.99834129281e3 --max-distance 2636.0183412928104e3 \
--l-distr fixed --longitude 17.819387435913086 --latitude -53.89456558227539 --i-distr uniform \
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
