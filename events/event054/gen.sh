lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 12.957637637637639 --fixed-mass2 39.76768768768769 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029940294.5589585 \
--gps-end-time 1029947494.5589585 \
--d-distr volume \
--min-distance 825.5197113741692e3 --max-distance 825.5397113741692e3 \
--l-distr fixed --longitude 171.93209838867188 --latitude 1.334492802619934 --i-distr uniform \
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
