lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 59.01377377377378 --fixed-mass2 17.327927927927927 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027915164.082199 \
--gps-end-time 1027922364.082199 \
--d-distr volume \
--min-distance 1127.21148876244e3 --max-distance 1127.23148876244e3 \
--l-distr fixed --longitude 29.269798278808594 --latitude -70.24395751953125 --i-distr uniform \
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
