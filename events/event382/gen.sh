lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 4.048968968968969 --fixed-mass2 12.201241241241242 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010828841.3542643 \
--gps-end-time 1010836041.3542643 \
--d-distr volume \
--min-distance 710.4313812780506e3 --max-distance 710.4513812780506e3 \
--l-distr fixed --longitude -104.12922668457031 --latitude 10.044893264770508 --i-distr uniform \
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
