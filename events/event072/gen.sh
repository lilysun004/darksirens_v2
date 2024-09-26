lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 24.807847847847846 --fixed-mass2 46.491211211211215 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029127338.2466402 \
--gps-end-time 1029134538.2466402 \
--d-distr volume \
--min-distance 1016.2148548744697e3 --max-distance 1016.2348548744696e3 \
--l-distr fixed --longitude -92.35504150390625 --latitude 11.993910789489746 --i-distr uniform \
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
