lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 42.373053053053056 --fixed-mass2 55.39987987987988 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002997760.9683359 \
--gps-end-time 1003004960.9683359 \
--d-distr volume \
--min-distance 1306.6495239964172e3 --max-distance 1306.6695239964172e3 \
--l-distr fixed --longitude -167.62277221679688 --latitude 33.64521789550781 --i-distr uniform \
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
