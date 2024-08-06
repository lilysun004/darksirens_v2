lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 41.86878878878879 --fixed-mass2 56.5764964964965 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024102928.0603986 \
--gps-end-time 1024110128.0603986 \
--d-distr volume \
--min-distance 3890.9301330469702e3 --max-distance 3890.9501330469707e3 \
--l-distr fixed --longitude 116.5523681640625 --latitude 21.03849220275879 --i-distr uniform \
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
