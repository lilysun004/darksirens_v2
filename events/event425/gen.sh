lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 42.541141141141146 --fixed-mass2 47.07951951951952 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1028999011.4912759 \
--gps-end-time 1029006211.4912759 \
--d-distr volume \
--min-distance 1656.7027252619237e3 --max-distance 1656.7227252619236e3 \
--l-distr fixed --longitude -98.00244140625 --latitude -33.58757781982422 --i-distr uniform \
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
