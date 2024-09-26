lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.3973973973974 --fixed-mass2 52.12216216216216 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022664938.2156652 \
--gps-end-time 1022672138.2156652 \
--d-distr volume \
--min-distance 2888.0069986860494e3 --max-distance 2888.02699868605e3 \
--l-distr fixed --longitude -141.33193969726562 --latitude -10.63475513458252 --i-distr uniform \
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
