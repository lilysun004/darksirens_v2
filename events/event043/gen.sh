lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 12.621461461461461 --fixed-mass2 20.68968968968969 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026705322.7509637 \
--gps-end-time 1026712522.7509637 \
--d-distr volume \
--min-distance 1113.0016286569155e3 --max-distance 1113.0216286569155e3 \
--l-distr fixed --longitude -46.15155029296875 --latitude 13.756528854370117 --i-distr uniform \
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
