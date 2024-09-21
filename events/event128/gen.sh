lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 28.16960960960961 --fixed-mass2 74.56192192192192 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000927614.5209785 \
--gps-end-time 1000934814.5209785 \
--d-distr volume \
--min-distance 2241.433093221278e3 --max-distance 2241.4530932212783e3 \
--l-distr fixed --longitude -45.948577880859375 --latitude 16.01566505432129 --i-distr uniform \
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
