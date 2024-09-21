lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 69.9394994994995 --fixed-mass2 83.97485485485485 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026967853.4433616 \
--gps-end-time 1026975053.4433616 \
--d-distr volume \
--min-distance 1337.5700033700048e3 --max-distance 1337.5900033700048e3 \
--l-distr fixed --longitude 13.426727294921875 --latitude 1.8489567041397095 --i-distr uniform \
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
