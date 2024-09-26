lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 19.513073073073073 --fixed-mass2 57.41693693693694 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027501428.7412529 \
--gps-end-time 1027508628.7412529 \
--d-distr volume \
--min-distance 757.254800923655e3 --max-distance 757.274800923655e3 \
--l-distr fixed --longitude -95.99566650390625 --latitude -8.831432342529297 --i-distr uniform \
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
