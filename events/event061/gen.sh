lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 5.3096296296296295 --fixed-mass2 32.62394394394394 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1012076879.1495665 \
--gps-end-time 1012084079.1495665 \
--d-distr volume \
--min-distance 920.710429202539e3 --max-distance 920.730429202539e3 \
--l-distr fixed --longitude 15.215278625488281 --latitude 7.565927505493164 --i-distr uniform \
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
