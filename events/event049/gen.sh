lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 29.766446446446444 --fixed-mass2 77.58750750750751 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005425068.3004055 \
--gps-end-time 1005432268.3004055 \
--d-distr volume \
--min-distance 2191.3878081325056e3 --max-distance 2191.407808132506e3 \
--l-distr fixed --longitude 81.02324676513672 --latitude -86.71188354492188 --i-distr uniform \
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
