lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 8.251171171171173 --fixed-mass2 50.35723723723724 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018796908.4017428 \
--gps-end-time 1018804108.4017428 \
--d-distr volume \
--min-distance 422.7252657539503e3 --max-distance 422.74526575395026e3 \
--l-distr fixed --longitude -36.83502197265625 --latitude -42.523746490478516 --i-distr uniform \
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
