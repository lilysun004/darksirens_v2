lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 23.126966966966965 --fixed-mass2 34.052692692692695 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025956684.2030191 \
--gps-end-time 1025963884.2030191 \
--d-distr volume \
--min-distance 981.3084181682649e3 --max-distance 981.3284181682649e3 \
--l-distr fixed --longitude 121.0541763305664 --latitude 13.943957328796387 --i-distr uniform \
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
