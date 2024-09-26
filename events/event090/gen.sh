lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 33.2962962962963 --fixed-mass2 34.052692692692695 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008586773.4045833 \
--gps-end-time 1008593973.4045833 \
--d-distr volume \
--min-distance 3095.1146128939004e3 --max-distance 3095.134612893901e3 \
--l-distr fixed --longitude 94.94612121582031 --latitude -38.18912887573242 --i-distr uniform \
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
