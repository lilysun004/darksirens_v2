lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 5.645805805805805 --fixed-mass2 75.23427427427428 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1015573568.7972624 \
--gps-end-time 1015580768.7972624 \
--d-distr volume \
--min-distance 5588.380556479391e3 --max-distance 5588.4005564793915e3 \
--l-distr fixed --longitude 104.23605346679688 --latitude -5.83777379989624 --i-distr uniform \
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
