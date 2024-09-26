lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 15.310870870870872 --fixed-mass2 6.318158158158158 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014810217.5287144 \
--gps-end-time 1014817417.5287144 \
--d-distr volume \
--min-distance 1058.9846823413086e3 --max-distance 1059.0046823413086e3 \
--l-distr fixed --longitude -14.89453125 --latitude 69.22486877441406 --i-distr uniform \
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
