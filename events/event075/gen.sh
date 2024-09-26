lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 27.581301301301302 --fixed-mass2 64.14046046046046 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006271513.703892 \
--gps-end-time 1006278713.703892 \
--d-distr volume \
--min-distance 2947.7332806883896e3 --max-distance 2947.75328068839e3 \
--l-distr fixed --longitude -20.47955322265625 --latitude 1.1484180688858032 --i-distr uniform \
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
