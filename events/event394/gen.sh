lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 26.992992992992992 --fixed-mass2 64.22450450450451 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001004794.8085158 \
--gps-end-time 1001011994.8085158 \
--d-distr volume \
--min-distance 2558.8582631549257e3 --max-distance 2558.878263154926e3 \
--l-distr fixed --longitude -105.31625366210938 --latitude -49.40199661254883 --i-distr uniform \
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
