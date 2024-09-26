lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 28.00152152152152 --fixed-mass2 53.550910910910915 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006078045.4481468 \
--gps-end-time 1006085245.4481468 \
--d-distr volume \
--min-distance 903.4550016844336e3 --max-distance 903.4750016844336e3 \
--l-distr fixed --longitude -41.83172607421875 --latitude -46.78553009033203 --i-distr uniform \
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
