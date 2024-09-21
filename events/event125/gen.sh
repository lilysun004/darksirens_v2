lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 38.338938938938945 --fixed-mass2 77.41941941941943 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1013401277.8905232 \
--gps-end-time 1013408477.8905232 \
--d-distr volume \
--min-distance 2238.0959088669774e3 --max-distance 2238.115908866978e3 \
--l-distr fixed --longitude -21.924407958984375 --latitude -19.974262237548828 --i-distr uniform \
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
