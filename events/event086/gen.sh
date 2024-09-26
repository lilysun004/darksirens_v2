lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 9.007567567567568 --fixed-mass2 62.711711711711715 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018980578.5346258 \
--gps-end-time 1018987778.5346258 \
--d-distr volume \
--min-distance 639.3354589716794e3 --max-distance 639.3554589716794e3 \
--l-distr fixed --longitude 40.65730285644531 --latitude -50.058868408203125 --i-distr uniform \
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
