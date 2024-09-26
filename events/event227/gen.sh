lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 14.890650650650652 --fixed-mass2 75.57045045045045 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016816759.4146417 \
--gps-end-time 1016823959.4146417 \
--d-distr volume \
--min-distance 1342.8111652976131e3 --max-distance 1342.831165297613e3 \
--l-distr fixed --longitude -168.96481323242188 --latitude -33.13145065307617 --i-distr uniform \
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
