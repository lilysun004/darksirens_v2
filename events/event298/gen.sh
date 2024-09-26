lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 11.024624624624625 --fixed-mass2 84.47911911911912 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005887322.5398607 \
--gps-end-time 1005894522.5398607 \
--d-distr volume \
--min-distance 771.4575437606737e3 --max-distance 771.4775437606737e3 \
--l-distr fixed --longitude 165.43460083007812 --latitude 42.62334060668945 --i-distr uniform \
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
