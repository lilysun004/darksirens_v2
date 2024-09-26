lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 17.58006006006006 --fixed-mass2 31.447327327327326 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005797372.1779087 \
--gps-end-time 1005804572.1779087 \
--d-distr volume \
--min-distance 1586.6166325619283e3 --max-distance 1586.6366325619283e3 \
--l-distr fixed --longitude 155.21624755859375 --latitude 11.655251502990723 --i-distr uniform \
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
