lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 47.331651651651654 --fixed-mass2 73.21721721721723 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018064152.600811 \
--gps-end-time 1018071352.600811 \
--d-distr volume \
--min-distance 1877.158092620866e3 --max-distance 1877.178092620866e3 \
--l-distr fixed --longitude 48.077674865722656 --latitude 59.19613265991211 --i-distr uniform \
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
