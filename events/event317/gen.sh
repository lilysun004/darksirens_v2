lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 63.804284284284286 --fixed-mass2 58.50950950950951 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027426287.5666354 \
--gps-end-time 1027433487.5666354 \
--d-distr volume \
--min-distance 2397.603963916059e3 --max-distance 2397.6239639160594e3 \
--l-distr fixed --longitude 175.9349365234375 --latitude 39.72328567504883 --i-distr uniform \
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
