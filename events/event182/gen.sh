lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 2.7042642642642645 --fixed-mass2 55.483923923923925 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016674960.4608077 \
--gps-end-time 1016682160.4608077 \
--d-distr volume \
--min-distance 495.6698804613225e3 --max-distance 495.6898804613225e3 \
--l-distr fixed --longitude -13.85552978515625 --latitude -31.29249382019043 --i-distr uniform \
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
