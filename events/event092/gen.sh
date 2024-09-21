lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 29.85049049049049 --fixed-mass2 68.93097097097098 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021890787.1374648 \
--gps-end-time 1021897987.1374648 \
--d-distr volume \
--min-distance 3432.4008669992677e3 --max-distance 3432.420866999268e3 \
--l-distr fixed --longitude 37.58653259277344 --latitude 12.888948440551758 --i-distr uniform \
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
