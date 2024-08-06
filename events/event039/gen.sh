lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 4.553233233233233 --fixed-mass2 69.01501501501502 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018229612.2518901 \
--gps-end-time 1018236812.2518901 \
--d-distr volume \
--min-distance 1033.4613538038398e3 --max-distance 1033.4813538038397e3 \
--l-distr fixed --longitude -58.7008056640625 --latitude 0.8745466470718384 --i-distr uniform \
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
