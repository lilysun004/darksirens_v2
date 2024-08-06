lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.907707707707708 --fixed-mass2 66.82986986986987 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014963287.6420017 \
--gps-end-time 1014970487.6420017 \
--d-distr volume \
--min-distance 1494.3732865103404e3 --max-distance 1494.3932865103404e3 \
--l-distr fixed --longitude 62.022193908691406 --latitude -28.518781661987305 --i-distr uniform \
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
