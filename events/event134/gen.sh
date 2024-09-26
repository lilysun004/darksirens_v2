lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 56.5764964964965 --fixed-mass2 82.96632632632632 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1003241013.5322187 \
--gps-end-time 1003248213.5322187 \
--d-distr volume \
--min-distance 1602.5638322906664e3 --max-distance 1602.5838322906664e3 \
--l-distr fixed --longitude -125.21463012695312 --latitude -57.112335205078125 --i-distr uniform \
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
