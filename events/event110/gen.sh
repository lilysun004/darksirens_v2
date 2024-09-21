lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 32.5398998998999 --fixed-mass2 57.16480480480481 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008106160.7424201 \
--gps-end-time 1008113360.7424201 \
--d-distr volume \
--min-distance 1082.2465681820745e3 --max-distance 1082.2665681820745e3 \
--l-distr fixed --longitude -15.7979736328125 --latitude -11.18802261352539 --i-distr uniform \
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
