lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 11.10866866866867 --fixed-mass2 45.56672672672673 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1011677515.5894008 \
--gps-end-time 1011684715.5894008 \
--d-distr volume \
--min-distance 433.43527924178557e3 --max-distance 433.45527924178555e3 \
--l-distr fixed --longitude 65.15438842773438 --latitude 22.107885360717773 --i-distr uniform \
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
