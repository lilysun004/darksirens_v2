lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 9.175655655655657 --fixed-mass2 57.33289289289289 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000000000 \
--gps-end-time 1000007200 \
--d-distr volume \
--min-distance 1421.3929651726255e3 --max-distance 1421.4129651726255e3 \
--l-distr fixed --longitude 54.73934294635815 --latitude -64.20708415018753 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower --L1=aLIGOZeroDetHighPower --I1=aLIGOZeroDetHighPower --V1=AdvVirgo --K1=KAGRA

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 I1 V1 K1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
