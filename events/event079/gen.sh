lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 20.185425425425425 --fixed-mass2 57.33289289289289 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008719982.8454384 \
--gps-end-time 1008727182.8454384 \
--d-distr volume \
--min-distance 2449.4799353065832e3 --max-distance 2449.4999353065837e3 \
--l-distr fixed --longitude -179.2742919921875 --latitude -37.08383560180664 --i-distr uniform \
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
