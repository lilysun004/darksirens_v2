lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 45.314594594594595 --fixed-mass2 71.2842042042042 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000917424.4355271 \
--gps-end-time 1000924624.4355271 \
--d-distr volume \
--min-distance 1769.8636297034066e3 --max-distance 1769.8836297034065e3 \
--l-distr fixed --longitude -69.09469604492188 --latitude -6.960141181945801 --i-distr uniform \
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
