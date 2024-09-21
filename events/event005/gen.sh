lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 34.38886886886887 --fixed-mass2 24.135495495495494 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1030020847.6329544 \
--gps-end-time 1030028047.6329544 \
--d-distr volume \
--min-distance 2787.9296952247987e3 --max-distance 2787.949695224799e3 \
--l-distr fixed --longitude 4.3035197257995605 --latitude -15.335162162780762 --i-distr uniform \
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
