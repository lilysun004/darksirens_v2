lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.3193993993994 --fixed-mass2 49.76892892892893 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023985614.5980221 \
--gps-end-time 1023992814.5980221 \
--d-distr volume \
--min-distance 1846.3386591236267e3 --max-distance 1846.3586591236267e3 \
--l-distr fixed --longitude 66.6214370727539 --latitude 10.832062721252441 --i-distr uniform \
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
