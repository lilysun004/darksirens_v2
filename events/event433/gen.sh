lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 24.471671671671672 --fixed-mass2 12.621461461461461 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008162760.655257 \
--gps-end-time 1008169960.655257 \
--d-distr volume \
--min-distance 1605.4843223956389e3 --max-distance 1605.5043223956388e3 \
--l-distr fixed --longitude -163.6815185546875 --latitude 28.515655517578125 --i-distr uniform \
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
