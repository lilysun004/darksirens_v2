lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 22.958878878878878 --fixed-mass2 34.052692692692695 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1017758003.7006932 \
--gps-end-time 1017765203.7006932 \
--d-distr volume \
--min-distance 111.46261051032802e3 --max-distance 111.48261051032803e3 \
--l-distr fixed --longitude -68.58895874023438 --latitude 14.136215209960938 --i-distr uniform \
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
