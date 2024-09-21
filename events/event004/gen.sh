lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 42.79327327327328 --fixed-mass2 36.069749749749754 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008363318.7256609 \
--gps-end-time 1008370518.7256609 \
--d-distr volume \
--min-distance 2062.1993805516418e3 --max-distance 2062.219380551642e3 \
--l-distr fixed --longitude -127.06951904296875 --latitude -29.303735733032227 --i-distr uniform \
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
