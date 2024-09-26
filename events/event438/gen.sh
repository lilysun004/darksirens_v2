lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 15.310870870870872 --fixed-mass2 62.62766766766767 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016660049.2497827 \
--gps-end-time 1016667249.2497827 \
--d-distr volume \
--min-distance 1296.8362082439407e3 --max-distance 1296.8562082439407e3 \
--l-distr fixed --longitude 84.54424285888672 --latitude 19.32732391357422 --i-distr uniform \
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
