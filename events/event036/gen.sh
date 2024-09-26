lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 58.761641641641646 --fixed-mass2 74.8980980980981 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029339615.2218622 \
--gps-end-time 1029346815.2218622 \
--d-distr volume \
--min-distance 2183.8741482180826e3 --max-distance 2183.894148218083e3 \
--l-distr fixed --longitude -107.64881896972656 --latitude -7.109588623046875 --i-distr uniform \
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
