lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 43.213493493493495 --fixed-mass2 80.44500500500502 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019757523.2426611 \
--gps-end-time 1019764723.2426611 \
--d-distr volume \
--min-distance 1410.022715169509e3 --max-distance 1410.042715169509e3 \
--l-distr fixed --longitude 104.60197448730469 --latitude -47.01249694824219 --i-distr uniform \
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
