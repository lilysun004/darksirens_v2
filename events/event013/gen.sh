lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 26.488728728728727 --fixed-mass2 64.22450450450451 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001618821.7845424 \
--gps-end-time 1001626021.7845424 \
--d-distr volume \
--min-distance 1668.250493490115e3 --max-distance 1668.270493490115e3 \
--l-distr fixed --longitude 175.30099487304688 --latitude 70.8222427368164 --i-distr uniform \
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
