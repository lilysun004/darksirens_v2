lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 7.578818818818819 --fixed-mass2 35.98570570570571 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021837154.7713741 \
--gps-end-time 1021844354.7713741 \
--d-distr volume \
--min-distance 1543.1376673572236e3 --max-distance 1543.1576673572235e3 \
--l-distr fixed --longitude -129.02145385742188 --latitude -68.60124969482422 --i-distr uniform \
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
