lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 9.932052052052052 --fixed-mass2 66.91391391391392 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024975633.6962953 \
--gps-end-time 1024982833.6962953 \
--d-distr volume \
--min-distance 562.0003155737405e3 --max-distance 562.0203155737405e3 \
--l-distr fixed --longitude 115.23088836669922 --latitude 40.52608871459961 --i-distr uniform \
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
