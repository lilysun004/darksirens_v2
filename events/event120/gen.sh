lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 27.16108108108108 --fixed-mass2 28.673873873873873 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1003463936.1062934 \
--gps-end-time 1003471136.1062934 \
--d-distr volume \
--min-distance 2420.9350416305733e3 --max-distance 2420.9550416305738e3 \
--l-distr fixed --longitude -69.66485595703125 --latitude 17.165334701538086 --i-distr uniform \
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
