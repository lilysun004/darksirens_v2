lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 39.095335335335335 --fixed-mass2 80.6130930930931 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025551300.033194 \
--gps-end-time 1025558500.033194 \
--d-distr volume \
--min-distance 5780.490231465459e3 --max-distance 5780.51023146546e3 \
--l-distr fixed --longitude 93.8208236694336 --latitude 29.3961181640625 --i-distr uniform \
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
