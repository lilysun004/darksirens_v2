lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 33.2962962962963 --fixed-mass2 74.30978978978979 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002766384.6501781 \
--gps-end-time 1002773584.6501781 \
--d-distr volume \
--min-distance 2619.0548697006407e3 --max-distance 2619.074869700641e3 \
--l-distr fixed --longitude -64.86447143554688 --latitude 44.265254974365234 --i-distr uniform \
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
