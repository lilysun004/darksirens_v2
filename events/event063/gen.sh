lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 60.778698698698705 --fixed-mass2 76.32684684684685 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000190568.5388191 \
--gps-end-time 1000197768.5388191 \
--d-distr volume \
--min-distance 1516.4258356225075e3 --max-distance 1516.4458356225075e3 \
--l-distr fixed --longitude -144.7467041015625 --latitude -40.946224212646484 --i-distr uniform \
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
