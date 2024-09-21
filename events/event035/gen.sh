lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 26.74086086086086 --fixed-mass2 69.18310310310311 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1015596788.8574252 \
--gps-end-time 1015603988.8574252 \
--d-distr volume \
--min-distance 957.6495243819495e3 --max-distance 957.6695243819495e3 \
--l-distr fixed --longitude 58.93743133544922 --latitude 57.18695068359375 --i-distr uniform \
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
