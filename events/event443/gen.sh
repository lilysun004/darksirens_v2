lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 57.753113113113116 --fixed-mass2 85.90786786786786 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021448903.8100092 \
--gps-end-time 1021456103.8100092 \
--d-distr volume \
--min-distance 4578.127714224914e3 --max-distance 4578.147714224914e3 \
--l-distr fixed --longitude -164.29689025878906 --latitude 53.26902389526367 --i-distr uniform \
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
