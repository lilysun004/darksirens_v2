lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 62.711711711711715 --fixed-mass2 37.91871871871872 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006924697.0954947 \
--gps-end-time 1006931897.0954947 \
--d-distr volume \
--min-distance 3818.988381934504e3 --max-distance 3819.0083819345045e3 \
--l-distr fixed --longitude -96.93731689453125 --latitude -17.204265594482422 --i-distr uniform \
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
