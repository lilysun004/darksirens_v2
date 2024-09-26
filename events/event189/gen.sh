lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 12.201241241241242 --fixed-mass2 59.686126126126126 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000742304.0725032 \
--gps-end-time 1000749504.0725032 \
--d-distr volume \
--min-distance 2379.1717486379493e3 --max-distance 2379.19174863795e3 \
--l-distr fixed --longitude 75.35126495361328 --latitude -28.1046085357666 --i-distr uniform \
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
