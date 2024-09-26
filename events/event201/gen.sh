lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 5.3096296296296295 --fixed-mass2 74.30978978978979 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1003507705.1649951 \
--gps-end-time 1003514905.1649951 \
--d-distr volume \
--min-distance 687.2366957151813e3 --max-distance 687.2566957151813e3 \
--l-distr fixed --longitude -44.35223388671875 --latitude -8.36832046508789 --i-distr uniform \
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
