lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 23.295055055055055 --fixed-mass2 79.01625625625626 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005466518.4094518 \
--gps-end-time 1005473718.4094518 \
--d-distr volume \
--min-distance 2572.4297576338136e3 --max-distance 2572.449757633814e3 \
--l-distr fixed --longitude 138.4649658203125 --latitude 29.64441680908203 --i-distr uniform \
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
