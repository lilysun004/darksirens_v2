lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 22.034394394394393 --fixed-mass2 64.64472472472472 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009437868.9208654 \
--gps-end-time 1009445068.9208654 \
--d-distr volume \
--min-distance 3357.897870122943e3 --max-distance 3357.9178701229434e3 \
--l-distr fixed --longitude 108.12744140625 --latitude 24.99107551574707 --i-distr uniform \
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
