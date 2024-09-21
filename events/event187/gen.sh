lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 37.75063063063063 --fixed-mass2 77.67155155155156 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016230670.832347 \
--gps-end-time 1016237870.832347 \
--d-distr volume \
--min-distance 3338.1552362197167e3 --max-distance 3338.175236219717e3 \
--l-distr fixed --longitude 67.4498291015625 --latitude 17.81871795654297 --i-distr uniform \
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
