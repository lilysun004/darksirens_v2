lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 30.69093093093093 --fixed-mass2 80.19287287287288 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1031037867.9080048 \
--gps-end-time 1031045067.9080048 \
--d-distr volume \
--min-distance 2162.659940930091e3 --max-distance 2162.6799409300916e3 \
--l-distr fixed --longitude -26.07879638671875 --latitude -79.349365234375 --i-distr uniform \
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
