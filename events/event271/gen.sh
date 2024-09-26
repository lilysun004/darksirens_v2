lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 7.158598598598599 --fixed-mass2 35.90166166166166 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019250293.6604155 \
--gps-end-time 1019257493.6604155 \
--d-distr volume \
--min-distance 1835.8908282028228e3 --max-distance 1835.9108282028228e3 \
--l-distr fixed --longitude -61.62945556640625 --latitude -36.2423210144043 --i-distr uniform \
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
