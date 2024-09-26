lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 34.220780780780785 --fixed-mass2 13.714034034034036 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002431298.7657294 \
--gps-end-time 1002438498.7657294 \
--d-distr volume \
--min-distance 817.0177313215157e3 --max-distance 817.0377313215157e3 \
--l-distr fixed --longitude 25.497676849365234 --latitude -50.553916931152344 --i-distr uniform \
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
