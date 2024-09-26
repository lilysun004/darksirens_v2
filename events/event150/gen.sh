lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 67.75435435435436 --fixed-mass2 37.66658658658659 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007708142.5959259 \
--gps-end-time 1007715342.5959259 \
--d-distr volume \
--min-distance 2975.83820744726e3 --max-distance 2975.8582074472606e3 \
--l-distr fixed --longitude -178.76315307617188 --latitude 45.39252471923828 --i-distr uniform \
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
