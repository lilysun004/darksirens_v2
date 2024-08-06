lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 12.369329329329329 --fixed-mass2 69.9394994994995 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026890029.1696767 \
--gps-end-time 1026897229.1696767 \
--d-distr volume \
--min-distance 326.207025460595e3 --max-distance 326.227025460595e3 \
--l-distr fixed --longitude -21.719696044921875 --latitude -8.083086013793945 --i-distr uniform \
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
