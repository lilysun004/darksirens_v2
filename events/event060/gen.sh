lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 18.336456456456457 --fixed-mass2 34.893133133133134 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027637968.3770481 \
--gps-end-time 1027645168.3770481 \
--d-distr volume \
--min-distance 1295.0110111971562e3 --max-distance 1295.0310111971562e3 \
--l-distr fixed --longitude -54.028472900390625 --latitude 47.11146926879883 --i-distr uniform \
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
