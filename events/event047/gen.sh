lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 32.5398998998999 --fixed-mass2 48.08804804804805 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022833578.9766331 \
--gps-end-time 1022840778.9766331 \
--d-distr volume \
--min-distance 2190.97583813175e3 --max-distance 2190.9958381317506e3 \
--l-distr fixed --longitude 155.7100830078125 --latitude -84.95222473144531 --i-distr uniform \
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
