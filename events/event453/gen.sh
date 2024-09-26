lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.73357357357358 --fixed-mass2 81.53757757757758 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023140868.9777446 \
--gps-end-time 1023148068.9777446 \
--d-distr volume \
--min-distance 2376.0088696250996e3 --max-distance 2376.0288696251e3 \
--l-distr fixed --longitude 166.745849609375 --latitude 33.67331314086914 --i-distr uniform \
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
