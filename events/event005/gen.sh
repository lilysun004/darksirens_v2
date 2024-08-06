lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 25.31211211211211 --fixed-mass2 46.491211211211215 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019714112.3005394 \
--gps-end-time 1019721312.3005394 \
--d-distr volume \
--min-distance 1558.9827987644558e3 --max-distance 1559.0027987644557e3 \
--l-distr fixed --longitude -42.3564453125 --latitude -56.80541229248047 --i-distr uniform \
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
