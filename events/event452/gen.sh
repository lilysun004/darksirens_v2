lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.98570570570571 --fixed-mass2 57.41693693693694 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020631344.9637705 \
--gps-end-time 1020638544.9637705 \
--d-distr volume \
--min-distance 568.0184368753607e3 --max-distance 568.0384368753607e3 \
--l-distr fixed --longitude -169.57301330566406 --latitude -66.26347351074219 --i-distr uniform \
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
