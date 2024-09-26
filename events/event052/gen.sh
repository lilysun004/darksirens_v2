lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 8.251171171171173 --fixed-mass2 68.67883883883884 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020978820.7500862 \
--gps-end-time 1020986020.7500862 \
--d-distr volume \
--min-distance 1174.267714171769e3 --max-distance 1174.287714171769e3 \
--l-distr fixed --longitude -10.65704345703125 --latitude -59.74066925048828 --i-distr uniform \
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
