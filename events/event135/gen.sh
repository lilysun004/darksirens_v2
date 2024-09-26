lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 19.765205205205206 --fixed-mass2 52.87855855855856 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020368658.6139231 \
--gps-end-time 1020375858.6139231 \
--d-distr volume \
--min-distance 1302.7876353404845e3 --max-distance 1302.8076353404845e3 \
--l-distr fixed --longitude 97.59809875488281 --latitude 63.19009017944336 --i-distr uniform \
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
