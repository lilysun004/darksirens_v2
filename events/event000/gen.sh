lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 17.58006006006006 --fixed-mass2 31.615415415415416 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1003229142.732949 \
--gps-end-time 1003236342.732949 \
--d-distr volume \
--min-distance 1408.526876510995e3 --max-distance 1408.546876510995e3 \
--l-distr fixed --longitude -25.0677490234375 --latitude 82.20380401611328 --i-distr uniform \
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
