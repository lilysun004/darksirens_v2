lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 14.134254254254255 --fixed-mass2 19.513073073073073 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016110383.9605548 \
--gps-end-time 1016117583.9605548 \
--d-distr volume \
--min-distance 951.9354481808921e3 --max-distance 951.9554481808921e3 \
--l-distr fixed --longitude -99.54156494140625 --latitude -10.712406158447266 --i-distr uniform \
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
