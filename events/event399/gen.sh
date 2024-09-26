lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 39.85173173173173 --fixed-mass2 40.103863863863864 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1011459343.6120181 \
--gps-end-time 1011466543.6120181 \
--d-distr volume \
--min-distance 1004.280412948075e3 --max-distance 1004.300412948075e3 \
--l-distr fixed --longitude -103.4447021484375 --latitude -18.347673416137695 --i-distr uniform \
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
