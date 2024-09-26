lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 6.822422422422423 --fixed-mass2 4.217057057057057 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022074475.5799766 \
--gps-end-time 1022081675.5799766 \
--d-distr volume \
--min-distance 703.5896081009221e3 --max-distance 703.6096081009221e3 \
--l-distr fixed --longitude -158.40310668945312 --latitude -53.85992431640625 --i-distr uniform \
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
