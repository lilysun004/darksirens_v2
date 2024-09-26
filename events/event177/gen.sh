lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 18.336456456456457 --fixed-mass2 82.46206206206206 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006996411.8086008 \
--gps-end-time 1007003611.8086008 \
--d-distr volume \
--min-distance 2847.6591937262624e3 --max-distance 2847.679193726263e3 \
--l-distr fixed --longitude 168.5650634765625 --latitude -21.404151916503906 --i-distr uniform \
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
