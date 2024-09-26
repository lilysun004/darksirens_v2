lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 6.15007007007007 --fixed-mass2 85.15147147147148 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024143369.4271197 \
--gps-end-time 1024150569.4271197 \
--d-distr volume \
--min-distance 1492.8409751544636e3 --max-distance 1492.8609751544636e3 \
--l-distr fixed --longitude -8.5640869140625 --latitude 39.348506927490234 --i-distr uniform \
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
