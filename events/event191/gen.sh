lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 14.218298298298297 --fixed-mass2 77.25133133133133 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008112273.5149511 \
--gps-end-time 1008119473.5149511 \
--d-distr volume \
--min-distance 1181.383265676511e3 --max-distance 1181.403265676511e3 \
--l-distr fixed --longitude 150.68930053710938 --latitude 44.0977783203125 --i-distr uniform \
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
