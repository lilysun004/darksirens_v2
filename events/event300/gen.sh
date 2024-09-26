lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 23.79931931931932 --fixed-mass2 69.77141141141142 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024213592.888318 \
--gps-end-time 1024220792.888318 \
--d-distr volume \
--min-distance 1623.6868736544097e3 --max-distance 1623.7068736544097e3 \
--l-distr fixed --longitude -106.05244445800781 --latitude -57.4802360534668 --i-distr uniform \
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
