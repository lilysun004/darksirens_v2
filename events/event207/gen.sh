lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.56548548548549 --fixed-mass2 78.00772772772773 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1030493195.438565 \
--gps-end-time 1030500395.438565 \
--d-distr volume \
--min-distance 2058.390358619088e3 --max-distance 2058.4103586190886e3 \
--l-distr fixed --longitude -80.24124145507812 --latitude -44.99515914916992 --i-distr uniform \
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
