lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 36.82614614614615 --fixed-mass2 50.02106106106106 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1013995597.5293757 \
--gps-end-time 1014002797.5293757 \
--d-distr volume \
--min-distance 728.8977556391479e3 --max-distance 728.9177556391479e3 \
--l-distr fixed --longitude -118.66783142089844 --latitude -24.127140045166016 --i-distr uniform \
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
