lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 20.353513513513512 --fixed-mass2 64.14046046046046 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008422968.5982823 \
--gps-end-time 1008430168.5982823 \
--d-distr volume \
--min-distance 1913.6027053562568e3 --max-distance 1913.6227053562568e3 \
--l-distr fixed --longitude 114.70198059082031 --latitude 40.754329681396484 --i-distr uniform \
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
