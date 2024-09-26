lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 45.314594594594595 --fixed-mass2 57.500980980980984 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1017277805.0162709 \
--gps-end-time 1017285005.0162709 \
--d-distr volume \
--min-distance 1116.1659793516487e3 --max-distance 1116.1859793516487e3 \
--l-distr fixed --longitude 7.586455821990967 --latitude 21.54905891418457 --i-distr uniform \
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
