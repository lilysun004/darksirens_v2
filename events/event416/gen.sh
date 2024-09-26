lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 29.01005005005005 --fixed-mass2 67.67031031031031 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000594683.8499671 \
--gps-end-time 1000601883.8499671 \
--d-distr volume \
--min-distance 798.857263859093e3 --max-distance 798.877263859093e3 \
--l-distr fixed --longitude 65.40538024902344 --latitude 48.377525329589844 --i-distr uniform \
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
