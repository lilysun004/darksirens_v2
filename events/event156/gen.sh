lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 26.404684684684685 --fixed-mass2 60.35847847847848 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000793828.4571472 \
--gps-end-time 1000801028.4571472 \
--d-distr volume \
--min-distance 958.4987117849704e3 --max-distance 958.5187117849704e3 \
--l-distr fixed --longitude -20.354400634765625 --latitude -61.25635528564453 --i-distr uniform \
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
