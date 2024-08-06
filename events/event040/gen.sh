lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 10.268228228228228 --fixed-mass2 21.614174174174174 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1003998779.4148346 \
--gps-end-time 1004005979.4148346 \
--d-distr volume \
--min-distance 893.8420233209396e3 --max-distance 893.8620233209396e3 \
--l-distr fixed --longitude -20.004547119140625 --latitude 51.160640716552734 --i-distr uniform \
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
