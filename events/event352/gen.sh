lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 42.87731731731732 --fixed-mass2 56.40840840840841 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024424348.8326105 \
--gps-end-time 1024431548.8326105 \
--d-distr volume \
--min-distance 4035.4812942204408e3 --max-distance 4035.501294220441e3 \
--l-distr fixed --longitude -110.64364624023438 --latitude -29.85213851928711 --i-distr uniform \
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
