lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 37.07827827827828 --fixed-mass2 15.05873873873874 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019866581.2775416 \
--gps-end-time 1019873781.2775416 \
--d-distr volume \
--min-distance 972.4743371051806e3 --max-distance 972.4943371051805e3 \
--l-distr fixed --longitude -82.02093505859375 --latitude -57.89569091796875 --i-distr uniform \
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
