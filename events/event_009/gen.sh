lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 20.185425425425425 --fixed-mass2 58.34142142142142 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000000000 \
--gps-end-time 1000007200 \
--d-distr volume \
--min-distance 1198.0942136731744e3 --max-distance 1198.1142136731744e3 \
--l-distr fixed --longitude 50.472916603520844 --latitude -55.905223778123506 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower --L1=aLIGOZeroDetHighPower --I1=aLIGOZeroDetHighPower --V1=AdvVirgo --K1=KAGRA

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 I1 V1 K1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
