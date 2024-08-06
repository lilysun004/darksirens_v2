lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 5.3096296296296295 --fixed-mass2 36.237837837837844 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020268687.0476598 \
--gps-end-time 1020275887.0476598 \
--d-distr volume \
--min-distance 705.5289394059497e3 --max-distance 705.5489394059497e3 \
--l-distr fixed --longitude -40.4879150390625 --latitude 45.07319259643555 --i-distr uniform \
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
