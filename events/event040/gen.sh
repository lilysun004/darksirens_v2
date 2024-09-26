lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.882122122122123 --fixed-mass2 57.08076076076076 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1031519505.2791938 \
--gps-end-time 1031526705.2791938 \
--d-distr volume \
--min-distance 329.75945092825924e3 --max-distance 329.7794509282592e3 \
--l-distr fixed --longitude -143.7291259765625 --latitude 80.11663818359375 --i-distr uniform \
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
