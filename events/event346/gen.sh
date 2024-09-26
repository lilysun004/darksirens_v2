lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 10.604404404404406 --fixed-mass2 53.88708708708709 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019351747.814847 \
--gps-end-time 1019358947.814847 \
--d-distr volume \
--min-distance 2039.822190538707e3 --max-distance 2039.842190538707e3 \
--l-distr fixed --longitude 108.69950866699219 --latitude 21.5880069732666 --i-distr uniform \
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
