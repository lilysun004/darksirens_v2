lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 25.90042042042042 --fixed-mass2 78.51199199199199 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016617090.0007691 \
--gps-end-time 1016624290.0007691 \
--d-distr volume \
--min-distance 1309.8833140551774e3 --max-distance 1309.9033140551774e3 \
--l-distr fixed --longitude -34.5615234375 --latitude 35.79264831542969 --i-distr uniform \
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
