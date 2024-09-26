lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 14.134254254254255 --fixed-mass2 32.11967967967968 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027597935.4472407 \
--gps-end-time 1027605135.4472407 \
--d-distr volume \
--min-distance 1093.5504676417013e3 --max-distance 1093.5704676417013e3 \
--l-distr fixed --longitude 65.30128479003906 --latitude 28.006669998168945 --i-distr uniform \
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
