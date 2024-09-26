lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 8.587347347347347 --fixed-mass2 30.354754754754754 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001994044.473094 \
--gps-end-time 1002001244.473094 \
--d-distr volume \
--min-distance 942.5672357848907e3 --max-distance 942.5872357848907e3 \
--l-distr fixed --longitude -143.72879028320312 --latitude -34.99179458618164 --i-distr uniform \
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
