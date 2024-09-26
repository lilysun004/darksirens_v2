lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 32.28776776776777 --fixed-mass2 55.652012012012015 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018105627.1182182 \
--gps-end-time 1018112827.1182182 \
--d-distr volume \
--min-distance 1040.8292058297425e3 --max-distance 1040.8492058297425e3 \
--l-distr fixed --longitude 92.96751403808594 --latitude -66.83056640625 --i-distr uniform \
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
