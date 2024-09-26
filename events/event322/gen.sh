lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 39.01129129129129 --fixed-mass2 71.03207207207207 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1011279988.6534598 \
--gps-end-time 1011287188.6534598 \
--d-distr volume \
--min-distance 3007.8643250491414e3 --max-distance 3007.884325049142e3 \
--l-distr fixed --longitude -86.30886840820312 --latitude 47.56538009643555 --i-distr uniform \
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
