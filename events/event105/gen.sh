lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 45.65077077077078 --fixed-mass2 39.93577577577578 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1015398579.362887 \
--gps-end-time 1015405779.362887 \
--d-distr volume \
--min-distance 3361.778841084772e3 --max-distance 3361.7988410847724e3 \
--l-distr fixed --longitude 4.6172051429748535 --latitude -31.30463218688965 --i-distr uniform \
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
