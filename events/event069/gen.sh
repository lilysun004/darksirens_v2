lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 41.112392392392394 --fixed-mass2 47.07951951951952 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1028417016.3245884 \
--gps-end-time 1028424216.3245884 \
--d-distr volume \
--min-distance 2139.348291717726e3 --max-distance 2139.3682917177266e3 \
--l-distr fixed --longitude 49.581871032714844 --latitude -30.826711654663086 --i-distr uniform \
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
