lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 57.92120120120121 --fixed-mass2 71.70442442442443 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007650607.0392367 \
--gps-end-time 1007657807.0392367 \
--d-distr volume \
--min-distance 2838.781388569901e3 --max-distance 2838.8013885699015e3 \
--l-distr fixed --longitude -25.791259765625 --latitude -12.34135627746582 --i-distr uniform \
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
