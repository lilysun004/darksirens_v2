lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 20.10138138138138 --fixed-mass2 28.505785785785786 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022639639.5977749 \
--gps-end-time 1022646839.5977749 \
--d-distr volume \
--min-distance 2494.4853946725198e3 --max-distance 2494.50539467252e3 \
--l-distr fixed --longitude 57.77079772949219 --latitude -24.12932014465332 --i-distr uniform \
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
