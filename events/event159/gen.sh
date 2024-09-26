lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 68.17457457457458 --fixed-mass2 45.398638638638644 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018696968.7553883 \
--gps-end-time 1018704168.7553883 \
--d-distr volume \
--min-distance 1896.6169122636588e3 --max-distance 1896.6369122636588e3 \
--l-distr fixed --longitude -0.61053466796875 --latitude 38.409889221191406 --i-distr uniform \
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
