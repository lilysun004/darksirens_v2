lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 37.66658658658659 --fixed-mass2 69.77141141141142 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1030433938.3201768 \
--gps-end-time 1030441138.3201768 \
--d-distr volume \
--min-distance 1453.527219322384e3 --max-distance 1453.547219322384e3 \
--l-distr fixed --longitude 133.17860412597656 --latitude -31.161663055419922 --i-distr uniform \
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
