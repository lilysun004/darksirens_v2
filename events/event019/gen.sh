lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 17.748148148148147 --fixed-mass2 61.11487487487488 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020591744.1561521 \
--gps-end-time 1020598944.1561521 \
--d-distr volume \
--min-distance 2373.006547965002e3 --max-distance 2373.0265479650025e3 \
--l-distr fixed --longitude -113.56781005859375 --latitude 1.9437552690505981 --i-distr uniform \
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
