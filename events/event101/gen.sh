lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 17.496016016016018 --fixed-mass2 70.86398398398399 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1012741155.8645403 \
--gps-end-time 1012748355.8645403 \
--d-distr volume \
--min-distance 1525.5000517649346e3 --max-distance 1525.5200517649346e3 \
--l-distr fixed --longitude -150.685302734375 --latitude -64.76573944091797 --i-distr uniform \
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
