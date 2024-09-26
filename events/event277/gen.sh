lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.966166166166165 --fixed-mass2 62.12340340340341 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001961886.4013995 \
--gps-end-time 1001969086.4013995 \
--d-distr volume \
--min-distance 1467.6031393041308e3 --max-distance 1467.6231393041307e3 \
--l-distr fixed --longitude -88.84524536132812 --latitude 32.877811431884766 --i-distr uniform \
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
