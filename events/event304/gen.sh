lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 20.353513513513512 --fixed-mass2 48.340180180180184 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010063462.9570276 \
--gps-end-time 1010070662.9570276 \
--d-distr volume \
--min-distance 2361.269875518423e3 --max-distance 2361.2898755184233e3 \
--l-distr fixed --longitude 122.32633972167969 --latitude -38.77552032470703 --i-distr uniform \
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
