lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 33.80056056056056 --fixed-mass2 77.08324324324325 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008419829.8014809 \
--gps-end-time 1008427029.8014809 \
--d-distr volume \
--min-distance 2058.4593818149774e3 --max-distance 2058.479381814978e3 \
--l-distr fixed --longitude 143.05477905273438 --latitude 11.16048526763916 --i-distr uniform \
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
