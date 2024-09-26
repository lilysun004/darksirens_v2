lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 40.01981981981982 --fixed-mass2 83.13441441441442 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008313176.4644305 \
--gps-end-time 1008320376.4644305 \
--d-distr volume \
--min-distance 1585.7928497162004e3 --max-distance 1585.8128497162004e3 \
--l-distr fixed --longitude 156.75442504882812 --latitude 74.37884521484375 --i-distr uniform \
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
