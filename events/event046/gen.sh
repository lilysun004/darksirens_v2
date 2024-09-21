lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 31.95159159159159 --fixed-mass2 80.44500500500502 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024122536.7112135 \
--gps-end-time 1024129736.7112135 \
--d-distr volume \
--min-distance 3719.853330988366e3 --max-distance 3719.8733309883664e3 \
--l-distr fixed --longitude 61.81172561645508 --latitude -13.892794609069824 --i-distr uniform \
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
