lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 33.2962962962963 --fixed-mass2 84.22698698698699 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001091549.1169691 \
--gps-end-time 1001098749.1169691 \
--d-distr volume \
--min-distance 2934.9467560367675e3 --max-distance 2934.966756036768e3 \
--l-distr fixed --longitude 148.35507202148438 --latitude 56.16285705566406 --i-distr uniform \
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
