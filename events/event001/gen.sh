lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 36.48996996996997 --fixed-mass2 80.86522522522523 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1012457525.7971598 \
--gps-end-time 1012464725.7971598 \
--d-distr volume \
--min-distance 3305.5868657061988e3 --max-distance 3305.606865706199e3 \
--l-distr fixed --longitude 139.78729248046875 --latitude 51.76341247558594 --i-distr uniform \
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
