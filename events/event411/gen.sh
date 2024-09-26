lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 9.511831831831831 --fixed-mass2 81.9577977977978 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019856408.9487361 \
--gps-end-time 1019863608.9487361 \
--d-distr volume \
--min-distance 984.6355519808014e3 --max-distance 984.6555519808014e3 \
--l-distr fixed --longitude 25.809619903564453 --latitude -4.494631767272949 --i-distr uniform \
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
