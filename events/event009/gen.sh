lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 11.024624624624625 --fixed-mass2 41.19643643643644 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010936623.5440545 \
--gps-end-time 1010943823.5440545 \
--d-distr volume \
--min-distance 1640.5201323514693e3 --max-distance 1640.5401323514693e3 \
--l-distr fixed --longitude -135.26806640625 --latitude 78.80207061767578 --i-distr uniform \
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
