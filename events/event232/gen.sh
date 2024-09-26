lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 38.254894894894896 --fixed-mass2 82.88228228228229 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024529486.1460325 \
--gps-end-time 1024536686.1460325 \
--d-distr volume \
--min-distance 1756.5714794078544e3 --max-distance 1756.5914794078544e3 \
--l-distr fixed --longitude 50.789085388183594 --latitude 36.065738677978516 --i-distr uniform \
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
