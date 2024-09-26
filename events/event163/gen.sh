lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 6.906466466466466 --fixed-mass2 46.07099099099099 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018918291.3754401 \
--gps-end-time 1018925491.3754401 \
--d-distr volume \
--min-distance 1243.8386998474873e3 --max-distance 1243.8586998474873e3 \
--l-distr fixed --longitude 104.4429931640625 --latitude 16.554553985595703 --i-distr uniform \
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
