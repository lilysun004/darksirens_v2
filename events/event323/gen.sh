lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 31.615415415415416 --fixed-mass2 71.95655655655656 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1003323639.9868449 \
--gps-end-time 1003330839.9868449 \
--d-distr volume \
--min-distance 2498.1140308991953e3 --max-distance 2498.1340308991957e3 \
--l-distr fixed --longitude 102.99547576904297 --latitude 23.028526306152344 --i-distr uniform \
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
