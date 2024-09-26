lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 38.170850850850854 --fixed-mass2 35.56548548548549 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026184539.1865442 \
--gps-end-time 1026191739.1865442 \
--d-distr volume \
--min-distance 3414.7104523425323e3 --max-distance 3414.7304523425328e3 \
--l-distr fixed --longitude 51.96844482421875 --latitude -10.794495582580566 --i-distr uniform \
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
