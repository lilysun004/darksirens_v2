lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 40.355995995996 --fixed-mass2 71.20016016016017 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1004490106.9442638 \
--gps-end-time 1004497306.9442638 \
--d-distr volume \
--min-distance 2374.2293218675463e3 --max-distance 2374.2493218675468e3 \
--l-distr fixed --longitude 44.09528732299805 --latitude -53.70536422729492 --i-distr uniform \
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
