lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 34.893133133133134 --fixed-mass2 73.63743743743744 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018641049.1987239 \
--gps-end-time 1018648249.1987239 \
--d-distr volume \
--min-distance 4708.814418681677e3 --max-distance 4708.834418681678e3 \
--l-distr fixed --longitude 82.9546127319336 --latitude 36.43170928955078 --i-distr uniform \
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
