lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 17.15983983983984 --fixed-mass2 54.30730730730731 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1017883435.7780979 \
--gps-end-time 1017890635.7780979 \
--d-distr volume \
--min-distance 1435.8626695585585e3 --max-distance 1435.8826695585585e3 \
--l-distr fixed --longitude -70.72900390625 --latitude 9.455163955688477 --i-distr uniform \
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
