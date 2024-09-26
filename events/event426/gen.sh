lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 28.505785785785786 --fixed-mass2 39.34746746746747 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000427006.653175 \
--gps-end-time 1000434206.653175 \
--d-distr volume \
--min-distance 2933.609943663763e3 --max-distance 2933.6299436637632e3 \
--l-distr fixed --longitude 82.81147766113281 --latitude -51.66404342651367 --i-distr uniform \
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
