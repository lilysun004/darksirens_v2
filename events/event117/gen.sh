lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 43.213493493493495 --fixed-mass2 80.52904904904905 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020751857.3097643 \
--gps-end-time 1020759057.3097643 \
--d-distr volume \
--min-distance 2551.6031863237386e3 --max-distance 2551.623186323739e3 \
--l-distr fixed --longitude -128.17503356933594 --latitude 45.28108215332031 --i-distr uniform \
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
