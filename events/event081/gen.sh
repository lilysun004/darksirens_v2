lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 20.26946946946947 --fixed-mass2 85.23551551551552 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009366443.9121108 \
--gps-end-time 1009373643.9121108 \
--d-distr volume \
--min-distance 1090.8809748102647e3 --max-distance 1090.9009748102646e3 \
--l-distr fixed --longitude 156.22750854492188 --latitude -4.463916778564453 --i-distr uniform \
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
