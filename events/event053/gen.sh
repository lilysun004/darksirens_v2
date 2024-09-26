lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 24.555715715715714 --fixed-mass2 78.17581581581582 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022247024.9738721 \
--gps-end-time 1022254224.9738721 \
--d-distr volume \
--min-distance 2725.356880507626e3 --max-distance 2725.3768805076265e3 \
--l-distr fixed --longitude 117.87605285644531 --latitude -23.103132247924805 --i-distr uniform \
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
