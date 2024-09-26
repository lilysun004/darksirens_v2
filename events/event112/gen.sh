lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 34.30482482482483 --fixed-mass2 75.57045045045045 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007618846.9685947 \
--gps-end-time 1007626046.9685947 \
--d-distr volume \
--min-distance 1712.550595256779e3 --max-distance 1712.570595256779e3 \
--l-distr fixed --longitude 3.1504099369049072 --latitude 23.627056121826172 --i-distr uniform \
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
